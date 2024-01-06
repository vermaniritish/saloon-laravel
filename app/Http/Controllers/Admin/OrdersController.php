<?php

/**
 * Pages Class
 *
 * @package    PagesController 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Admin\Permissions;
use App\Models\Admin\Coupons;
use App\Models\Admin\Admins;
use App\Models\Admin\BlogCategories;
use Illuminate\Validation\Rule;
use Illuminate\Support\Str;
use App\Libraries\FileSystem;
use App\Http\Controllers\Admin\AppController;
use App\Models\Admin\Addresses;
use App\Models\Admin\Orders;
use App\Models\Admin\ProductCategories;
use App\Models\Admin\Products;
use App\Models\Admin\Settings;
use App\Models\Admin\Users;
use App\Models\User;
use Illuminate\Support\Facades\Storage;

class OrdersController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

    function index(Request $request)
    {
    	if(!Permissions::hasPermission('orders', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$where = [];
    	if($request->get('search'))
    	{
    		$search = $request->get('search');
    		$search = '%' . $search . '%';
    		$where['(
				orders.id LIKE ? or
				orders.title LIKE ? or
			 	owner.first_name LIKE ? or 
				owner.last_name LIKE ?)'] = [$search, $search, $search, $search];
    	}

    	if($request->get('created_on'))
    	{
    		$createdOn = $request->get('created_on');
    		if(isset($createdOn[0]) && !empty($createdOn[0]))
    			$where['orders.created >= ?'] = [
    				date('Y-m-d 00:00:00', strtotime($createdOn[0]))
    			];
    		if(isset($createdOn[1]) && !empty($createdOn[1]))
    			$where['orders.created <= ?'] = [
    				date('Y-m-d 23:59:59', strtotime($createdOn[1]))
    			];
    	}

    	if($request->get('admins'))
    	{
    		$admins = $request->get('admins');
    		$admins = $admins ? implode(',', $admins) : 0;
    		$where[] = 'orders.created_by IN ('.$admins.')';
    	}

    	$listing = Orders::getListing($request, $where);


    	if($request->ajax())
    	{
		    $html = view(
	    		"admin/orders/listingLoop", 
	    		[
	    			'listing' => $listing
	    		]
	    	)->render();

		    return Response()->json([
		    	'status' => 'success',
	            'html' => $html,
	            'page' => $listing->currentPage(),
	            'counter' => $listing->perPage(),
	            'count' => $listing->total(),
	            'pagination_counter' => $listing->currentPage() * $listing->perPage()
	        ], 200);
		}
		else
		{
			$filters = $this->filters($request);
	    	return view(
	    		"admin/orders/index", 
	    		[
	    			'listing' => $listing,
	    			'admins' => $filters['admins']
	    		]
	    	);
	    }
    }

    function filters(Request $request)
    {
		$admins = [];
		$adminIds = Orders::distinct()->whereNotNull('created_by')->pluck('created_by')->toArray();
		if($adminIds)
		{
	    	$admins = Admins::getAll(
	    		[
	    			'admins.id',
	    			'admins.first_name',
	    			'admins.last_name',
	    			'admins.status',
	    		],
	    		[
	    			'admins.id in ('.implode(',', $adminIds).')'
	    		],
	    		'concat(admins.first_name, admins.last_name) desc'
	    	);
	    }
    	return [
	    	'admins' => $admins
    	];
    }

    function add(Request $request)
    {
    	if(!Permissions::hasPermission('orders', 'create'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	if($request->isMethod('post'))
    	{
    		$data = $request->toArray();
    		unset($data['_token']);
    		$validator = Validator::make(
	            $request->toArray(),
	            [
					'customer_id' => ['required', Rule::exists(User::class,'id')],
					'product_id' => ['required', 'array'],
    				'product_id.*' => ['required', Rule::exists(Products::class,'id')],
					'booking_date' => ['required', 'date'],
					'booking_time' => ['required', 'after_or_equal:today'],
					'manual_address' => ['required','boolean'],
					'address' => ['required_if:manual_address,true','string','max:255'],
					'state' => ['required_if:manual_address,true','string','max:40'],
					'city' => ['required_if:manual_address,true','string','max:30'],
					'area' => ['required_if:manual_address,true','string','max:40'],
					'address_id' => ['exclude_if:manual_address,true','required_if:manual_address,false',Rule::exists(Addresses::class,'id')],
					'payment_type' => ['required'], 
					'coupon_code_id' => ['nullable',Rule::exists(Coupons::class,'id')], 
					'subtotal' => ['required', 'numeric'],
					'discount' => ['required', 'numeric'],
					'tax' => ['required', 'numeric'],
					'total_amount' => ['required', 'numeric'],
	            ]
	        );
	        if(!$validator->fails())
	        {
				$products = [];
	        	if(isset($data['product_id']) && $data['product_id']) {
	        		$products = $data['product_id'];
	        	}
				unset($data['product_id']);
				$formattedDateTime = date('Y-m-d H:i:s', strtotime($request->get('booking_date')));
				$data['booking_date'] = $formattedDateTime;
				$customerId = $request->input('customer_id');
				$user = User::find($customerId);
				if($user){
					$data['customer_name'] = $user->first_name . ' ' . $user->last_name; 
				}
				if (!$data['manual_address']) {
					$address = Addresses::where('id', $data['address_id'])->first();
					if($address){
						$data['address'] = $address->address; 
						$data['city'] = $address->city; 
						$data['state'] = $address->state; 
						$data['area'] = $address->area; 
						$input['latitude'] = $address->latitude;
						$input['longitude'] = $address->longitude;
					}
				}
	        	$order = Orders::create($data);
	        	if($order)
	        	{
					$order_prefix = (int)Settings::get('order_prefix');
					$data['prefix_id'] = $order->id + $order_prefix;
					Orders::modify($order->id,$data);
					if(!empty($products))
	        		{  
	        			Orders::handleProducts($order->id, $products);
	        		}
	        		$request->session()->flash('success', 'Order created successfully.');
	        		return redirect()->route('admin.orders');
	        	}
	        	else
	        	{
	        		$request->session()->flash('error', 'Order could not be save. Please try again.');
		    		return redirect()->back()->withErrors($validator)->withInput();
	        	}
		    }
		    else
		    {
		    	$request->session()->flash('error', 'Please provide valid inputs.');
		    	return redirect()->back()->withErrors($validator)->withInput();
		    }
		}
		$users = Users::getAll(
			[
				'users.id',
				'users.first_name',
				'users.last_name',
				'users.status',
			],
			[
			],
			'concat(users.first_name, users.last_name) desc'
		);
		$productCategories = ProductCategories::with('products')
		->get(['id', 'title']); 
	    $address = Addresses::getAll(
			[
				'addresses.id',
				'addresses.address',
				'addresses.city',
				'addresses.area',
				'addresses.state',
			],
			[
			]
		);
		$coupons = Coupons::getAll(
			[
				'coupons.id',
				'coupons.title',
				'coupons.is_percentage',
				'coupons.amount',
			],
			[
			]
		);
	    return view("admin/orders/add", [
			'users' => $users,
			'productCategories' => $productCategories,
			'address' => $address,
			'coupons' => $coupons,
			'paymentType' => Orders::getStaticData()['paymentType'],
			'tax_percentage' => Settings::get('tax_percentage')
	    ]);
    }

    function view(Request $request, $id)
    {
    	if(!Permissions::hasPermission('orders', 'listing'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$page = Orders::get($id);
    	if($page)
    	{
	    	return view("admin/orders/view", [
    			'page' => $page,
				'status' => Orders::getStaticData()['status'],

    		]);
		}
		else
		{
			abort(404);
		}
    }

    function edit(Request $request, $id)
    {
    	if(!Permissions::hasPermission('orders', 'update'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$page = Orders::get($id);

    	if($page)
    	{
	    	if($request->isMethod('post'))
	    	{
	    		$data = $request->toArray();
	    		$validator = Validator::make(
		            $request->toArray(),
		            [
						'title' => ['required'],
						'coupon_code' => ['required', Rule::unique('coupons','coupon_code')->ignore($page->id)],
						'max_use' => ['required', 'integer'],
						'end_date' => ['required', 'after_or_equal:today'],
						'description' => 'nullable',
		            ]
		        );

		        if(!$validator->fails())
		        {
					$formattedDateTime = date('Y-m-d H:i:s', strtotime($request->get('end_date')));
					$data['end_date'] = $formattedDateTime;
		        	unset($data['_token']);
		        	if(Orders::modify($id, $data))
		        	{
		        		$request->session()->flash('success', 'Coupon updated successfully.');
		        		return redirect()->route('admin.orders');
		        	}
		        	else
		        	{
		        		$request->session()->flash('error', 'Order could not be save. Please try again.');
			    		return redirect()->back()->withErrors($validator)->withInput();
		        	}
			    }
			    else
			    {
			    	$request->session()->flash('error', 'Please provide valid inputs.');
			    	return redirect()->back()->withErrors($validator)->withInput();
			    }
			}

			return view("admin/orders/edit", [
    			'page' => $page
    		]);
		}
		else
		{
			abort(404);
		}
    }

    function delete(Request $request, $id)
    {
    	if(!Permissions::hasPermission('orders', 'delete'))
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$admin = Orders::find($id);
    	if($admin->delete())
    	{
    		$request->session()->flash('success', 'Coupon deleted successfully.');
    		return redirect()->route('admin.orders');
    	}
    	else
    	{
    		$request->session()->flash('error', 'Order could not be delete.');
    		return redirect()->route('admin.orders');
    	}
    }

    function bulkActions(Request $request, $action)
    {
    	if( ($action != 'delete' && !Permissions::hasPermission('orders', 'update')) || ($action == 'delete' && !Permissions::hasPermission('orders', 'delete')) )
    	{
    		$request->session()->flash('error', 'Permission denied.');
    		return redirect()->route('admin.dashboard');
    	}

    	$ids = $request->get('ids');
    	if(is_array($ids) && !empty($ids))
    	{
    		switch ($action) {
    			case 'active':
    				Orders::modifyAll($ids, [
    					'status' => 1
    				]);
    				$message = count($ids) . ' records has been published.';
    			break;
    			case 'inactive':
    				Orders::modifyAll($ids, [
    					'status' => 0
    				]);
    				$message = count($ids) . ' records has been unpublished.';
    			break;
    			case 'delete':
    				Orders::removeAll($ids);
    				$message = count($ids) . ' records has been deleted.';
    			break;
    		}

    		$request->session()->flash('success', $message);

    		return Response()->json([
    			'status' => 'success',
	            'message' => $message,
	        ], 200);		
    	}
    	else
    	{
    		return Response()->json([
    			'status' => 'error',
	            'message' => 'Please select atleast one record.',
	        ], 200);	
    	}
    }

	function switchStatus(Request $request, $field, $id)
	{
		if (!Permissions::hasPermission('diary_pages', 'update')) {
		$request->session()->flash('error', 'Permission denied.');
		return redirect()->route('admin.dashboard');
		}
		$data = $request->toArray();
		$validator = Validator::make(
		$request->toArray(),
		[
			'flag' => 'required'
		]
		);
		if (!$validator->fails()) {
		$order = Orders::find($id);
		if($order){
			$updated = $order->updateStatusAndLogHistory($field, $request->get('flag'));
		}
		if ($updated) {
			return Response()->json([
			'status' => 'success',
			'message' => 'Record updated successfully.'
			]);
		} else {
			return Response()->json([
			'status' => 'error',
			'message' => 'Record could not be update.'
			]);
		}
		} else {
		return Response()->json([
			'status' => 'error',
			'message' => 'Record could not be update.'
		]);
		}
	}
	
	public function getStatuses()
	{
		return response()->json(Orders::getStaticData()['status']);
	}
}

<?php
/**
 * Products Class
 *
 * @package    ProductsController
 
 
 * @version    Release: 1.0.0
 * @since      Class available since Release 1.0.0
 */


namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use App\Models\Admin\Settings;
use App\Models\API\ApiAuth;
use App\Libraries\General;
use App\Models\API\Products;
use App\Models\API\ProductCategories;
use App\Models\API\UsersWishlist;
use App\Models\API\ProductReports;
use App\Models\Admin\ProductCategoryRelation;
use App\Libraries\FileSystem;
use App\Libraries\Google;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

class ProductsController extends AppController
{
	function __construct()
	{
		parent::__construct();
	}

	function categories(Request $request)
	{
		$where = [];
		$items = ProductCategories::select([
                'product_categories.id',
                'product_categories.title',
                'product_categories.slug',
                'product_categories.image'
            ])
            ->orderBy('product_categories.title', 'asc')
            ->get();
	    return Response()->json([
	    	'status' => true,
            'categories' => $items
        ], 200);
	}

	function makeWishlist(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'id' => 'required',
            	'wishlist' => 'required',
            ]
        );

        
		if(!$validator->fails())
		{
			$product = Products::select(['id', 'slug'])->where('id', $request->get('id'))->first();
			if($product)
			{
				$userId = ApiAuth::getLoginId();

				if($request->get('wishlist'))
				{
					$wishlist = UsersWishlist::create($request->get('id'), $userId);
					if($wishlist)
					{
						$user = ApiAuth::getLoginUser();
						$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product added to your wishlist.',
				            'wishlist' => $request->get('wishlist'),
				            'product' => Products::getBySlug($product->slug),
				            'user' => $user
				        ]);
					}
					else
					{
						return Response()->json([
					    	'status' => false,
					    	'message' => 'Product could not mark as wishlist.'
				        ], 400);
					}
				}
				else
				{
					$wishlist = UsersWishlist::remove($request->get('id'), $userId);
					if($wishlist)
					{
						$user = ApiAuth::getLoginUser();
						$user->wishlist = UsersWishlist::where('user_id', $user->id)->pluck('product_id')->toArray();
						
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product removed from your wishlist.',
				            'wishlist' => $request->get('wishlist'),
				            'user' => $user
				        ]);
					}
					else
					{
				        return Response()->json([
					    	'status' => false,
					    	'message' => 'Product could not remove from wishlist.',
				        ], 400);
					}	
				}
				
			}
			else
			{
				return Response()->json([
			    	'status' => false,
		            'message' => 'Product is missing.'
		        ], 400);
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		}
	}

	/**
	* To Upload File
	* @param Request $request
	*/
    function uploadFile(Request $request)
    {
    	$validator = Validator::make(
            $request->toArray(),
            [
                'file' => 'required',
            ]
        );

    	if(!$validator->fails())
	    {
	    	if($request->file('file')->isValid())
	    	{
	    		$file = null;
	    		$file = FileSystem::uploadImage(
    				$request->file('file'),
    				'products'
    			);

    			if($file)
    			{
    				$names = explode('/', $file);
    				$originalName = end($names);

    				FileSystem::resizeImage($file, 'L-' . $originalName, '970*672');
    				$resized = FileSystem::resizeImage($file, 'M-' . $originalName, '485*336');
    				FileSystem::resizeImage($file, 'S-' . $originalName, '235*162');

    				
					return Response()->json([
				    	'status' => true,
				    	'message' => 'File uploaded successfully.',
				    	'url' => url($resized),
				    	'name' => $originalName,
				    	'path' => $file
				    ]);
    				
    			}
    			else
    			{
    				return Response()->json([
				    	'status' => false,
				    	'message' => 'File could not be upload.'
				    ], 400);
    			}
	    	}
	    	else
	    	{
	    		return Response()->json([
		    	'status' => false,
		    	'message' => 'File could not be uploaded.'
		    ], 400);
	    	}
	   	}
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'File could not be uploaded due to missing parameters.'
		    ], 400);
	    }
    }

    /**
	* To Remove File
	* @param Request $request
	*/
    function removeFile(Request $request)
    {
    	$data = $request->toArray();

    	$validator = Validator::make(
            $request->toArray(),
            [
                'file' => 'required',
            ]
        );

    	if(!$validator->fails())
	    {
	    	$deleted = false;

	    	if(isset($data['id']) && $data['id'])
	    	{
	    		$product = Products::select(['id', Db::raw('image as photos')])->where('id', $data['id'])->first();
	    		if($product)
	    		{
	    			$photos = $product->photos ? json_decode($product->photos, true) : [];
	    			$index = array_search($data['file'], $photos);
	    			if($index > -1)
	    			{
	    				unset($photos[$index]);
	    			}

	    			Products::modify($product->id, [
	    				'image' => $photos ? json_encode($photos) : null
	    			]);
	    			$deleted = FileSystem::deleteFile($data['file']);
	    			return Response()->json([
				    	'status' => true,
				    	'message' => 'File deleted successfully.'
				    ]);
	    		}
	    		else
	    		{
	    			return Response()->json([
				    	'status' => false,
				    	'message' => 'File could not be deleted.'
				    ], 400);
	    		}
	    	}
	    	else
	    	{
	    		$deleted = FileSystem::deleteFile($data['file']);
	    	}


	    	if($deleted)
    		{
    			return Response()->json([
			    	'status' => 'success',
			    	'message' => 'File deleted successfully.'
			    ]);
    		}
    		else
    		{
	    		return Response()->json([
			    	'status' => false,
			    	'message' => 'File could not be deleted.'
			    ], 400);
	    	}
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'File parameter is missing.'
		    ], 400);
	    }
    }

    function create(Request $request)
    {
    	$allowed = ['image', 'title', 'postcode', 'address', 'description', 'price', 'sale_price', 'lat', 'lng', 'categories', 'is_draft', 'lat', 'lng'];
    	if($request->has($allowed))
    	{
    		$data = $request->toArray();

    		$validator = Validator::make(
	            $request->toArray(),
	            [
	                'title' => 'required',
	                'categories' => 'required',
	                'address' => 'required',
	                'image' => 'required',
	                'price' => 'required|numeric',
	                'sale_price' => 'nullable|numeric',
	            ]
	        );

	        if(!$validator->fails())
	        {
	        	$product = null;
	        	$existingImages = [];
	        	if(isset($data['id']) && $data['id'])
	        	{
		        	$product = Products::find($data['id']);
		        	if(!$product)
		        	{
		        		return Response()->json([
		    				'status' => false,
				    		'message' => 'Not Found!'
					    ], 400);
		        	}

		        	if($product->image)
		        	{
		        		$existingImages = Arr::pluck($product->image, 'original');
		        	}
		        }
		        unset($data['id']);

	        	$categories = [];
	        	if(isset($data['categories']) && $data['categories']) {
	        		$categories = $data['categories'];
	        	}
	        	unset($data['categories']);
				
				$data['sale_price'] = $data['sale_price'] > 0 && $data['sale_price'] < $data['price'] ? $data['sale_price'] : null;
				$images = [];
				$cropedArea = [];
				if(!empty($data['image']))
				{
					foreach($data['image'] as $v)
					{
						if(strpos($v['path'], '?') > -1)
						{
							$v['path'] = explode('?', $v['path']);
	    					unset($v['path'][count($v['path']) - 1]);
	    					$v['path'] = implode('/', $v['path']);
	    				}

						$images[] = $v['path'];
						$names = explode('/', $v['path']);
    					$originalName = end($names);
    					if(isset($v['cropped']) && !empty($v['cropped']) && isset($v['cropped']['image']) && $v['cropped']['image'])
    					{
    						
	    					$file = FileSystem::saveBase64Image(
    							$v['path'], 
    							'L-' . $originalName, 
    							$v['cropped']['image']
	    					);

	    					if(file_exists(public_path($file)))
	    					{
		    					copy(public_path($file), public_path(FileSystem::getOnlyPath($file) . '/M-' . $originalName));
		    					$resized = FileSystem::resizeImage($file, 'M-' . $originalName, '485*336');

		    					copy(public_path($file), public_path(FileSystem::getOnlyPath($file) . '/S-' . $originalName));
		    					FileSystem::resizeImage($file, 'S-' . $originalName, '235*162');

		    					FileSystem::resizeImage($file, 'L-' . $originalName, '970*672');
		    				}
	    				}

	    				unset($v['cropped']['image']);
	    				$cropedArea[] = isset($v['cropped']) && $v['cropped'] ? $v['cropped'] : null;
					}
				}

				$data['cropped_area'] = json_encode($cropedArea);
				$data['image'] = json_encode($images);
				$data['status'] = $data['is_draft'] ? 0 : 1;
				unset($data['is_draft']);
				$data['user_id'] = ApiAuth::getLoginId();
				
				if($product)
				{
					$saved = Products::modify($product->id, $data);
				}
	        	else
	        	{
	        		$saved = Products::create($data);
	        	}

	        	if($saved)
	        	{
	        		if(!empty($categories))
	        		{
	        			Products::handleCategories($saved->id, $categories);
	        		}

	        		return Response()->json([
				    	'status' => true,
				    	'message' => 'Product created successfully.',
				    	'product' => Products::get($saved->id)
				    ]);
	        	}
	        	else
	        	{
	        		return Response()->json([
				    	'status' => false,
				    	'message' => 'Product could not be save. Please try again.'
				    ], 400);
	        	}
		    }
		    else
		    {
		    	return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		    }
		}
		else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Some of inputs are invalid in request.',
		    ], 400);
	    }
    }

    function report(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'reasons' => 'required',
            	'id' => 'required',
            ]
        );
        
		if(!$validator->fails())
		{
			$product = Products::select(['id'])->where('id', $request->get('id'))->first();
			if($product)
			{
				$userId = ApiAuth::getLoginId();
				$exist = ProductReports::select(['id'])
					->where('ip', $request->getClientIp())
					->where('product_id', $request->get('id'))
					->first();
				if(!$exist)
				{
					$report = new ProductReports();
					$report->product_id = $request->get('id');
					$report->user_id = $userId ? $userId : null;
					$report->reasons = json_encode($request->get('reasons'));
					$report->ip = $request->getClientIp();
					$report->created = date('Y-m-d H:i:s');
					$report->modified = date('Y-m-d H:i:s');
					if($report->save())
					{
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product reported.'
				        ]);
					}
					else
					{
						return Response()->json([
					    	'status' => true,
					    	'message' => 'Product could not be reported.',
				        ], 400);
					}
				}
				else
				{
					return Response()->json([
					    	'status' => true,
					    	'message' => 'Product has already been reported by you.',
				        ], 400);
				}
				
			}
			else
			{
				return Response()->json([
			    	'status' => false,
		            'message' => 'Product is missing.'
		        ], 400);
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		}
	}

	function changeStatus(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'status' => 'required',
            	'id' => 'required',
            ]
        );
        
		if(!$validator->fails())
		{
			$id = $request->get('id');
			$userId = ApiAuth::getLoginId();
			$data = [];
			switch ($request->get('status')) {
				case 'sold':
					$data['sold'] = 1;
				break;
				case 'unsold':
					$data['sold'] = 0;
				break;
				case 'draft':
					$data['status'] = 0;
				break;
				case 'active':
					$data['status'] = 1;
				break;
				
			}

			if($id && is_array($id))
			{
				if(Products::modifyAll($id, $data))
				{
					return Response()->json([
				    	'status' => true,
				    	'message' => 'Products updated.'
			        ]);
				}
				else
				{
					return Response()->json([
				    	'status' => true,
				    	'message' => 'Products could not be update.',
			        ], 400);
				}
			}
			elseif($id)
			{
				$product = Products::select(['id'])->where('id', $request->get('id'))
					->where('user_id', $userId)
					->first();

				if(!$product)
				{
					return Response()->json([
				    	'status' => false,
			            'message' => 'Product is missing.'
			        ], 400);
				}

				if(Products::modify($product->id, $data))
				{
					$product = Products::select([
						'id',
						'title',
						'slug',
						'image',
						'price',
						'sale_price',
						'status',
						'sold'
					])
					->where('id', $product->id)
					->first();

					return Response()->json([
				    	'status' => true,
				    	'message' => 'Product updated.',
				    	'product' => Products::getBySlug($product->slug),
				    	'saved' => $product
			        ]);
				}
				else
				{
					return Response()->json([
				    	'status' => true,
				    	'message' => 'Product could not be update.',
			        ], 400);
				}
			}
			else
			{
				return Response()->json([
			    	'status' => false,
		            'message' => 'Please selecte atleast one record.'
		        ], 400);
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		}
	}

	function myListing(Request $request)
	{
		$userId = ApiAuth::getLoginId();
		$sort = $request->get('sort');
		
		$products = Products::select([
				'id',
				'title',
				'slug',
				'image',
				'price',
				'sale_price',
				'status',
				'sold',
				DB::raw('(CASE WHEN sold = 1 and status = 1 THEN '.($sort == 'sold' ? '2' : ($sort == 'draft' ? '1' : '0') ).' ELSE (CASE WHEN status = 1 THEN 1 ELSE 0 END) END) as sort_status'),
				'modified'
			])
			->where('user_id', $userId);

		switch ($sort) {
			case 'active':
				 $products->orderBy('sort_status', 'desc');
			break;
			case 'draft':
				 $products->orderBy('sort_status', 'asc');
			break;
			case 'sold':
				 $products->orderBy('sort_status', 'desc');
			break;
			default:
				$products->orderBy('id', 'desc');
			break;
		}

		$conditions = [];
		
		if($request->get('draft'))
		{
			$conditions[] = "status = 0";
		}
		
		if($request->get('active'))
		{
			$conditions[] = "(status = 1 and sold = 0)";
		}

		if($request->get('sold'))
		{
			$conditions[] = "sold = 1";
		}

		if(!empty($conditions))
		{
			$products->whereRaw('('.implode(' or ', $conditions).')');
		}
		else
		{
			$products->whereRaw('id < 0');
		}

		$products = $products->get();

		return Response()->json([
	    	'status' => true,
	    	'products' => $products
        ]);
	}

	function updatePricing(Request $request)
	{
		$validator = Validator::make(
            $request->toArray(),
            [
            	'price' => 'required',
            	'id' => 'required',
            	'sale_price' => 'nullable',
            ]
        );
        
		if(!$validator->fails())
		{
			$userId = ApiAuth::getLoginId();
			$product = Products::where('id', $request->get('id'))
				->where('user_id', $userId)
				->first();
			if($product)
			{
				$data = $request->toArray();
				$product->sale_price = $data['sale_price'] = $data['sale_price'] > 0 && $data['sale_price'] < $data['price'] ? $data['sale_price'] : null;
				$product->price = $data['price'];
				if($product->save())
				{
					$product = Products::select([
						'id',
						'title',
						'slug',
						'image',
						'price',
						'sale_price',
						'status',
						'sold'
					])
					->where('id', $product->id)
					->first();
					return Response()->json([
				    	'status' => true,
				    	'message' => 'Product updated.',
				    	'product' => $product
			        ]);
				}
				else
				{
					return Response()->json([
				    	'status' => true,
				    	'message' => 'Product could not be update.',
			        ], 400);
				}
			}
			else
			{
				return Response()->json([
			    	'status' => false,
		            'message' => 'Product is missing.'
		        ], 400);
			}
		}
		else
		{
			return Response()->json([
			    	'status' => false,
			    	'message' => current( current( $validator->errors()->getMessages() ) )
			    ], 400);
		}
	}

	/**
	* To delete product
	* @param Request $request
	*/
    function delete(Request $request)
    {
    	$data = $request->toArray();
    	$userId = ApiAuth::getLoginId();

    	$validator = Validator::make(
            $request->toArray(),
            [
                'id' => 'required',
            ]
        );

    	if(!$validator->fails())
	    {
	    	$product = Products::select(['id', 'image'])
    			->where('id', $request->get('id'))
    			->where('user_id', $userId)
    			->first();
    		if($product)
    		{
    			$id = $request->get('id');
    			$deleted = false;
    			
    			if($id && is_array($id))
    			{
    				$deleted = Products::removeAll($id);
    			}
    			else
    			{
    				$deleted = Products::remove($id);
    			}

		    	if($deleted)
	    		{
	    			return Response()->json([
				    	'status' => 'success',
				    	'message' => 'Product deleted successfully.'
				    ]);
	    		}
	    		else
	    		{
		    		return Response()->json([
				    	'status' => false,
				    	'message' => 'Product could not be delete.'
				    ], 400);
		    	}
		    }
		    else
		    {
		    	return Response()->json([
				    	'status' => false,
				    	'message' => 'Product is missing.'
				    ], 400);
		    }
	    }
	    else
	    {
	    	return Response()->json([
		    	'status' => false,
		    	'message' => 'Product is missing.'
		    ], 400);
	    }
    }
}
<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\OrdersResource;
use Illuminate\Support\Facades\Validator;
use App\Models\API\Orders;
use App\Models\Admin\OrderProductRelation;
use App\Models\Admin\Settings;
use App\Models\API\Addresses;
use App\Models\API\Coupons;
use App\Models\Admin\Products;
use App\Models\API\Users;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\DB;

class OrdersController extends BaseController
{

    /**
     * Fetch Orders as per customer.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCustomerOrders(Request $request, $token){
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $orders = Orders::select([
            'prefix_id as id',
            'address', 
            'booking_date', 
            'booking_time', 
            'total_amount', 
            'status', 
            'created',
            DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
        ])->whereCustomerId($user->id)->orderBy('id', 'desc')->get();
        return Response()
                ->json([
                    'status' => true,
                    'data' => $orders,
                    'static' => Orders::getStaticData(),
                    'user' => $user
                ]);
    }

    public function detail(Request $request, $token, $id)
    {
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $order = Orders::select([
            'prefix_id as id',
            'address', 
            'booking_date', 
            'booking_time', 
            'subtotal',
            'discount',
            'coupon',
            'cgst',
            'sgst',
            'igst',
            DB::raw('((our_profit * cgst)/100) as cgst_tax'),
            DB::raw('((our_profit * sgst)/100) as sgst_tax'),
            DB::raw('((our_profit * igst)/100) as igst_tax'),
            'total_amount', 
            'status', 
            'created',
            DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
        ])->with(['products', 'products.brands'])->whereCustomerId($user->id)->where('prefix_id', $id)->orderBy('id', 'desc')->limit(1)->first();
        return Response()
                ->json([
                    'status' => true,
                    'data' => $order,
                    'static' => Orders::getStaticData(),
                    'user' => $user
                ]);
    }

    public function cancelBooking(Request $request, $token) {
        $user = Users::select(['id', 'first_name', 'phonenumber'])->where('token', $token)
            ->where('token_expiry', '>', date('Y-m-d H:i'))
            ->whereNotNull('token_expiry')
            ->where('status', 1)
            ->limit(1)
            ->first();
        if (!$user) {
            return Response()
                ->json([
                    'status' => false,
                    'authRequired' => true
                ]);
        }
        $order = Orders::whereCustomerId($user->id)->where('id', $request->get('id'))->orderBy('id', 'desc')->limit(1)->first();
        if($order)
        {
            $order->status = 'cancel';
            if($order->save())
            {
                $order->updateStatusAndLogHistory('status', 'cancel_by_client', $order->id);

                $order = Orders::select([
                    'id',
                    'address', 
                    'booking_date', 
                    'booking_time', 
                    'subtotal',
                    'cgst',
                    'sgst',
                    'tax',
                    'total_amount', 
                    'status', 
                    'created',
                    DB::raw("(Select sum(quantity) from order_products op where op.order_id = orders.id limit 1) as service_count")
                ])->with(['products', 'products.brands'])->where('id', $order->id)->orderBy('id', 'desc')->limit(1)->first();

                return Response()->json([
                    'status' => true,
                    'order' => $order
                ]);
            }
        }
        return Response()->json([
            'status' => false,
        ]);
    }
    
	function createBooking(Request $request)
	{
		$data = $request->toArray();
		$validator = Validator::make(
			$data,
			[
                'token' => ['required'],
				'name' => ['required'],
				'date' => ['required', 'date'],
				'time' => ['required', 'after_or_equal:today'],
				'address' => ['required'],
				'cart' => ['required'],
                'cart' => ['required', 'array'],
                'cart.*.id' => ['required', Rule::exists(Products::class, 'id')->where(function ($query) {
                    $query->where('status', 1)->whereNull('deleted_at');
                })],
                'cart.*.quantity' => ['required', 'integer', 'min:1'],
			]
		);
		if(!$validator->fails())
		{
            $user = Users::select(['id', 'first_name'])->where('token', $data['token'])
                ->where('token_expiry', '>', date('Y-m-d H:i'))
                ->whereNotNull('token_expiry')
                ->where('status', 1)
                ->limit(1)
                ->first();
			if($user)
            {
                $user->first_name = $request->get('name') ? $request->get('name') : $user->first_name;
                $user->save();
                
                $order = new Orders();
                $order->customer_name = $user->first_name;
                $order->customer_id = $user->id;
                $order->manual_address = 1;
                $order->address = $data['address'];
                $order->city = $data['city'];
                $order->booking_date = date('Y-m-d', strtotime($data['date']));
                $order->booking_time = date('H:i', strtotime($data['time']));
                $order->latitude = isset($data['lat']) && $data['lat'] ? $data['lat'] : null;
                $order->longitude = isset($data['lng']) && $data['lng'] ? $data['lng'] : null;
                $order->coupon = isset($data['coupon']) && $data['coupon'] ? json_encode($data['coupon']) : null;
                $order->status = 'pending';
                $order->status_at = date('Y-m-d H:i:s');
                $order->created = date('Y-m-d H:i:s');
                if($order->save()) 
                {
                    $order->prefix_id = Settings::get('order_prefix') + $order->id;
                    $order->partner_margin = Settings::get('partner_margin');
                    $order->travel_charges = Settings::get('travel_charges');
                    $order->shaguna_margin = Settings::get('shaguna_margin');
                    $order->platform_charges = Settings::get('platform_charges');
                    $order->buffer_margin_percent = Settings::get('buffer_margin_percent');
                    $order->buffer_margin_amount = Settings::get('buffer_margin_amount');
                    $order->shaguna_margin_percent = Settings::get('shaguna_margin_percent');
                    $order->save();

                    
                    $products = [];
                    $discount = 0;
                    $subtotal = 0;
                    $margin = 0;
                    $includeTravelCharges = false;
                    foreach($data['cart'] as $c)
                    {
                        $product = Products::select(['id', 'title', 'base_price', 'service_price', 'price', 'description', 'duration_of_service'])->where('id', $c['id'])->limit(1)->first();
                        if($product)
                        {
                            $price = Products::getPrice([
                                    'price' => $product->price,
                                    'base_price' => $product->base_price,
                                    'service_price' => $product->service_price,
                                    'duration_of_service' => $product->duration_of_service
                                ],
                                $order->partner_margin,
                                $order->travel_charges,
                                $order->shaguna_margin,
                                $order->partner_charges,
                                $order->buffer_margin_percent,
                                $order->buffer_margin_amount,
                                $order->shaguna_margin_percent
                            );

                            $products[] = [
                                'order_id' => $order->id,
                                'product_id' => $product->id,
                                'product_title' => $product->title,
                                'product_description' => $product->description,
                                'amount' => $price,
                                'quantity' => $c['quantity'],
                                'duration_of_service' => $product->duration_of_service,
                                'updated_at' => now() 
                            ];

                            $subtotal += $price * $c['quantity'];
                            $includeTravelCharges = $includeTravelCharges ? $includeTravelCharges : ($product->base_price ? true : false);
                            $margin += Products::getMyProfit([
                                    'price' => $product->price,
                                    'base_price' => $product->base_price,
                                    'service_price' => $product->service_price,
                                    'duration_of_service' => $product->duration_of_service
                                ],
                                $order->city,
                                $order->partner_margin,
                                $order->travel_charges,
                                $order->shaguna_margin,
                                $order->partner_charges,
                                $order->buffer_margin_percent,
                                $order->buffer_margin_amount,
                                $order->shaguna_margin_percent
                            );
                        }
                    }

                    if($products)
                    {
                        OrderProductRelation::insert($products);
                        
                        $cgst = Settings::get('cgst');
                        $sgst = Settings::get('sgst');
                        $igst = Settings::get('igst');
                        $punjab = ["Mohali", "Ludhiana"];
                        
                        if(isset($data['coupon']) && $data['coupon']) {
                            $discount = $data['coupon']['is_percentage'] ? (($subtotal * $data['coupon']['amount'])/100) : ($subtotal <= $data['coupon']['amount'] ? $subtotal : $data['coupon']['amount']);
                        }
                        $ourMargin = ( ($margin - $discount) - ($includeTravelCharges ? $order->travel_charges : 0));

                        if(in_array($order->city, $punjab))
                        {
                            $tax = ($ourMargin * $cgst)/100;
                            $tax += ($ourMargin * $sgst)/100;
                        }
                        else
                        {
                            $tax = ($ourMargin * $igst)/100;
                        }
                        $order->our_profit = $ourMargin;
                        $order->subtotal = $subtotal;
                        $order->discount = $discount;
                        $order->cgst = in_array($order->city, $punjab) ? $cgst : null;
                        $order->sgst = in_array($order->city, $punjab) ? $sgst : null;
                        $order->igst = !in_array($order->city, $punjab) ? $igst : null;
                        $order->tax = $tax;
                        $order->total_amount = $order->subtotal - $order->discount + $order->tax;
                        $order->staff_payment = $order->subtotal - $order->discount - $ourMargin;
                        $order->save();
                    }

                    return Response()->json([
                        'status' => true,
                        'orderId' => $order->prefix_id
                    ]);
                }
                else
                {
                    return Response()->json([
                        'status' => true
                    ]);
                }
            }
            else
            {
                return Response()
                    ->json([
                        'status' => false,
                        'authRequired' => true
                    ]);
            }
		}
		else
		{
            return Response()
                ->json([
                    'status' => false,
                    'clear' => true,
                    'message' => 'Something went wrong. Please try again.'
                ]);
		}
	}
}

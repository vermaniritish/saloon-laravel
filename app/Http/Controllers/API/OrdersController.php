<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\OrdersResource;
use App\Models\API\Orders;
use App\Models\Admin\Settings;
use App\Models\API\Addresses;
use App\Models\API\Coupons;
use App\Models\API\Products;
use App\Models\API\Users;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Validation\Rule;

class OrdersController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        return $this->_index($request, Orders::class, OrdersResource::class, []);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $last_order_time = Orders::whereCustomerId($request->get('customer_id'))->orderBy('created', 'desc')->value('created');
        $timeDifference = Carbon::parse($last_order_time)->addMinutes(30)->diffForHumans(Carbon::now());
        if($last_order_time && Carbon::parse($last_order_time)->toDateTimeString() > Carbon::now()->subMinutes(30)) {
            return $this->error(trans('CAN_NOT_CREATE_ORDER', ['TIME' => $timeDifference]), Response::HTTP_UNAUTHORIZED);
        }
        $input = $request->validate([
            'customer_id' => ['required', Rule::exists(User::class, 'id')],
            'product_id' => ['required', 'array'],
            'product_id.*' => ['required', Rule::exists(Products::class, 'id')->where(function ($query) {
                $query->where('status', 1);
            })],
            'booking_date' => ['required', 'date'],
            'booking_time' => ['required', 'after_or_equal:today'],
            'address_id' => ['exclude_if:manual_address,true','required_if:manual_address,false',Rule::exists(Addresses::class, 'id')],
            'payment_type' => ['required'],
            'coupon_code_id' => ['nullable', Rule::exists(Coupons::class, 'id')->where(function ($query) {
                $query->where('status', 1);
            })],
            'manual_address' => ['required','boolean'],
            'address' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:255'],
            'state' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:40'],
            'city' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:30'],
            'area' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:40'],
            'productsData' => ['required', 'array'],
            'productsData.*.id' => ['required', Rule::exists(Products::class, 'id')->where(function ($query) {
                $query->where('status', 1);
            })],
            'productsData.*.quantity' => ['required', 'integer', 'min:1'],
        ]);
        $formattedDateTime = date('Y-m-d H:i:s', strtotime($request->get('booking_date')));
        $input['booking_date'] = $formattedDateTime;
        $subtotal = 0;
        $productIds = collect($input['productsData'])->pluck('id');
        $products = Products::findMany($productIds);
        $subtotal = $products->sum(function ($product) use ($input) {
            $quantity = collect($input['productsData'])->firstWhere('id', $product->id)['quantity'] ?? 0;
            return $product->price * $quantity;
        });
        $discount = 0;
       if(isset($input['coupon_code_id']) && $input['coupon_code_id']){
           $coupon = Coupons::where('id', $input['coupon_code_id'])->first(['amount','is_percentage']);
           if($coupon && $coupon->is_percentage) {
               $discount = ($coupon->amount / 100) * $subtotal;
           } else {
               $discount = $coupon->amount;
           }
       }
       else{
        $discount = 0;
       }
        $taxPercentage = (int) Settings::get('tax_percentage');
        $input['tax'] = ($subtotal - $discount) * $taxPercentage / 100;
        $input['total_amount'] = $subtotal - $discount + $input['tax'];
        $input['discount'] = $discount;
        $input['subtotal'] = $subtotal;
        $productData = [];
    	$productData = $input['productsData'];
        unset($input['product_id']);
        unset($input['productsData']);
        $user = User::find($input['customer_id']);
        if($user) {
            $input['customer_name'] = $user->first_name . ' ' . $user->last_name;
        }
        if (!$input['manual_address']) {
            $address = Addresses::where('id', $input['address_id'])->first();
                if($address) {
                    $input['address'] = $address->address;
                    $input['city'] = $address->city;
                    $input['state'] = $address->state;
                    $input['area'] = $address->area;
                    $input['latitude'] = $address->latitude;
                    $input['longitude'] = $address->longitude;
                }
        }
        $order = Orders::create($input);
        if($order) {
            $order_prefix = (int)Settings::get('order_prefix');
            $data['prefix_id'] = $order->id + $order_prefix;
            Orders::modify($order->id,$data);
            if(!empty($productData)) {
                Orders::handleProducts($order->id, $productData);
            }
            return $this->success([], Response::HTTP_OK, trans('ORDER_CREATED'));
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_order = Orders::whereId($id)->first();
        if (!$check_order) {
            return $this->error(trans('ORDER_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new OrdersResource($check_order), Response::HTTP_OK);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(Request $request, string $id)
    {
        $check_order = Orders::whereId($id)->first();
        if (!$check_order) {
            return $this->error(trans('ORDER_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $input = $request->validate([
            'customer_id' => ['required', Rule::exists(User::class, 'id')],
            'product_id' => ['required', 'array'],
            'product_id.*' => ['required', Rule::exists(Products::class, 'id')],
            'booking_date' => ['required', 'date'],
            'booking_time' => ['required', 'after_or_equal:today'],
            'address_id' => ['exclude_if:manual_address,true','required_if:manual_address,false',Rule::exists(Addresses::class, 'id')],
            'payment_type' => ['required'],
            'coupon_code_id' => ['nullable',Rule::exists(Coupons::class, 'id')],
            'manual_address' => ['required','boolean'],
            'address' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:255'],
            'state' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:40'],
            'city' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:30'],
            'area' => ['exclude_if:manual_address,false','required_if:manual_address,true','string','max:40'],
        ]);

        $formattedDateTime = date('Y-m-d H:i:s', strtotime($request->get('booking_date')));
        $input['booking_date'] = $formattedDateTime;
        $subtotal = Products::findMany($input['product_id'])->pluck('price')->sum();
       if(isset($input['coupon_code_id']) && $input['coupon_code_id']){
           $coupon = Coupons::where('id', $input['coupon_code_id'])->first(['amount','is_percentage']);
           if($coupon && $coupon->is_percentage) {
               $discount = ($coupon->amount / 100) * $subtotal;
           } else {
               $discount = $coupon->amount;
           }
       }
       else{
            $discount = 0;
       }
        $taxPercentage = (int) Settings::get('tax_percentage');
        $input['tax'] = ($subtotal - $discount) * $taxPercentage / 100;
        $input['total_amount'] = $subtotal - $discount + $input['tax'];
        $input['discount'] = $discount;
        $input['subtotal'] = $subtotal;
        $products = [];
        if(isset($input['product_id']) && $input['product_id']) {
            $products = $input['product_id'];
        }
        unset($input['product_id']);
        $user = User::find($input['customer_id']);
        if($user) {
            $input['customer_name'] = $user->first_name . ' ' . $user->last_name;
        }
        if (!$input['manual_address']) {
            $address = Addresses::where('id', $input['address_id'])->first();
                if($address) {
                    $input['address'] = $address->address;
                    $input['city'] = $address->city;
                    $input['state'] = $address->state;
                    $input['area'] = $address->area;
                    $input['latitude'] = $address->latitude;
                    $input['longitude'] = $address->longitude;
                }
        }
        $order = Orders::modify($id,$input);
        if($order) {
            $order_prefix = (int)Settings::get('order_prefix');
            $data['prefix_id'] = $id + $order_prefix;
            Orders::modify($id,$data);
            if(!empty($products)) {
                Orders::handleProducts($order->id, $products);
            }
            return $this->success([], Response::HTTP_OK, trans('ORDER_UPDATED'));
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $check_order = Orders::whereId($id)->first();
        if (!$check_order) {
            return $this->error(trans('ORDER_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $check_order->delete();

        return $this->success([], Response::HTTP_OK, trans('ORDER_DELETED'));
    }

    /**
     * Fetch Orders as per customer.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getCustomerOrders(Request $request, $id){
        $check_user = Users::whereId($id)->exists();
        if (!$check_user) {
            return $this->error(trans('USER_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }
        $check_order = Orders::whereCustomerId($id)->first();
        return $this->success(new OrdersResource($check_order), Response::HTTP_OK);
    }
}

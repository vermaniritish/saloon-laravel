<?php

namespace App\Http\Controllers\API;

use App\Http\Resources\OrdersResource;
use App\Models\API\Orders;
use App\Models\Admin\Settings;
use App\Models\API\Addresses;
use App\Models\API\Coupons;
use App\Models\API\Products;
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
            'product_id.*' => ['required', Rule::exists(Products::class, 'id')],
            'booking_date' => ['required', 'date'],
            'booking_time' => ['required', 'after_or_equal:today'],
            'address_id' => ['nullable',Rule::exists(Addresses::class, 'id')],
            'payment_type' => ['required'],
            'coupon_code_id' => ['required',Rule::exists(Coupons::class, 'id')],
            'manual_address' => ['required','boolean'],
            'address' => ['required_if:manual_address,true','string','max:255'],
            'state' => ['required_if:manual_address,true','string','max:40'],
            'city' => ['required_if:manual_address,true','string','max:30'],
            'area' => ['required_if:manual_address,true','string','max:40'],
        ]);

        $formattedDateTime = date('Y-m-d H:i:s', strtotime($request->get('booking_date')));
        $input['booking_date'] = $formattedDateTime;
        $subtotal = Products::findMany($input['product_id'])->pluck('price')->sum();
        $coupon = Coupons::where('id', $input['coupon_code_id'])->first(['amount','is_percentage']);
        if($coupon->is_percentage) {
            $discount = ($coupon->amount / 100) * $subtotal;
        } else {
            $discount = $coupon->amount;
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
        $address = Addresses::where('id', $input['address_id'])->first();
        if($user) {
            $input['customer_name'] = $user->first_name . ' ' . $user->last_name;
        }
        if($address) {
            $input['address'] = $address->address;
            $input['city'] = $address->city;
            $input['state'] = $address->state;
            $input['area'] = $address->area;
        }
        unset($input['manual_address']);
        $order = Orders::create($input);
        if($order) {
            if(!empty($products)) {
                Orders::handleProducts($order->id, $products);
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
            return $this->error(trans('PRODUCT_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $input = $request->validate([
            // 'brand_id' => ['required','string',Rule::exists(Brands::class, 'id')],
            'product_name' => ['filled', 'string','max:40'],
            'product_description' => ['filled', 'string', 'max:255'],
            'product_categories' => ['filled','array'],
            'product_categories.*' => ['string','max:40'],
            'image' => ['filled','image','max:2048'],
            'price' => ['filled', 'integer'],
            'sale_price' => ['filled', 'integer'],
        ]);

        Orders::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('ORDER_UPDATED'));
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
}

<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use Illuminate\Http\Request;
use App\Http\Resources\ProductCategoriesResource;
use App\Models\API\ProductCategories;
use App\Models\Admin\Settings;
use App\Models\Admin\Orders;
use App\Models\Admin\Products;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class ProductCategoriesController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        $data = ProductCategories::with('products')->get()->toArray();
        // $data = ProductCategoriesResource::collection($productCategories)->toArray();
        $partnerCharges = Settings::get('partner_margin');
        $travelCharges = Settings::get('travel_charges');
        $shagunaMargin = Settings::get('shaguna_margin');
        $platformCharges = Settings::get('platform_charges');
        $bufferMarginPercent = Settings::get('buffer_margin_percent');
        $bufferMarginAmount = Settings::get('buffer_margin_amount');
        $shagunaMarginAmount = Settings::get('shaguna_margin_percent');
        $cart = $request->get('cart') ? json_decode($request->get('cart'), true) : [];
        $cart = $cart ? $cart : [];
        foreach($data as $k => $d)
        {
            foreach($d['products'] as $pk => $p)
            {
                $p['price'] = Products::getPrice($p, $partnerCharges, $travelCharges, $shagunaMargin, $platformCharges, $bufferMarginPercent, $bufferMarginAmount, $shagunaMarginAmount);
                if($cart && isset($cart['product_' . $p['id']]) && $cart['product_' . $p['id']])
                {
                    $p['quantity'] = $cart['product_' . $p['id']]['quantity'];
                    $p['deduction'] = Products::getMyProfit($p, $request->get('city'), $partnerCharges, $travelCharges, $shagunaMargin, $platformCharges, $bufferMarginPercent, $bufferMarginAmount, $shagunaMarginAmount);
                }
                $data[$k]['products'][$pk] = $p;
            }
        }

        return Response()->json([
            'data' => $data,
            'travelCharges' => ($travelCharges),
            'gst' => Settings::get('igst'),
            'host' => strpos(request()->getHttpHost(), 'shaguna'),
            'runningOrder' => Orders::select(['prefix_id'])
                ->where('status', '!=', 'completed')
                ->where('status', '!=', 'cancel')
                ->orderBy('booking_date', 'asc')
                ->limit(1)
                ->pluck('prefix_id')
                ->first()
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $input = $request->validate([
            'brand_name' => ['required', 'string','max:40'],
            'brand_description' => ['nullable', 'string', 'max:255'],
            'image' => ['required','image','max:2048']
        ]);
        $input['id'] = Str::uuid();
        $image = $input['image'];
        $image_extension = $image->getClientOriginalExtension();
        $filename = Str::uuid() . '.' . $image_extension;
        Storage::disk('brand_images')->put($filename, $image->getContent());
        unset($input['image']);
        $input['image_name'] = $filename;
        $input['image_path'] = Storage::disk('brand_images')->path('');
        ProductCategories::create($input);

        return $this->success([], Response::HTTP_OK, trans('CATEGORY_CREATED'));
    }

    /**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_brand = ProductCategories::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('CATEGORY_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new ProductCategoriesResource($check_brand), Response::HTTP_OK);
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
        $check_brand = ProductCategories::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('CATEGORY_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $input = $request->validate([
            'brand_name' => ['filled', 'string','max:40'],
            'brand_description' => ['filled', 'string', 'max:255'],
            'image' => ['required','image','max:2048']

        ]);

        if($request->has('image')) {
            $image = $input['image'];
            $image_extension = $image->getClientOriginalExtension();
            $filename = Str::uuid() . '.' . $image_extension;
            Storage::disk('brand_images')->put($filename, $image->getContent());
            unset($input['image']);
            $input['image_name'] = $filename;
            $input['image_path'] = Storage::disk('brand_images')->path('');
        }

        ProductCategories::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('CATEGORY_UPDATED'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $check_brand = ProductCategories::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('CATEGORY_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $check_brand->delete();

        return $this->success([], Response::HTTP_OK, trans('CATEGORY_DELETED'));
    }

}

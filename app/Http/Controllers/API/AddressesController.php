<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\API\BaseController;
use Illuminate\Http\Request;
use App\Http\Resources\BrandsResource;
use App\Http\Resources\AddressesResource;
use App\Models\Admin\AdminAuth;
use App\Models\API\Addresses;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;

class AddressesController extends BaseController
{
    /**
     * Display a listing of the resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        return $this->_index($request, Addresses::class, AddressesResource::class, []);
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
            'title' => ['required','string','max:255',],
            'address' => ['required','string','max:255',],
            'city' => ['required','string','max:255',],
            'state' => ['required','string','max:255',],
            'area' => ['required','string','max:255',],
            'latitude' => ['required','numeric',],
            'longitude' => ['required','numeric',]
        ]);
        $input['user_id'] = AdminAuth::getLoginId();
        Addresses::create($input);
        return $this->success([], Response::HTTP_OK, trans('ADDRESS_CREATED'));
    }

    /**
     * Display the specified resource.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(string $id)
    {
        $check_brand = Addresses::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('ADDRESS_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        return $this->success(new BrandsResource($check_brand), Response::HTTP_OK);
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
        $check_brand = Addresses::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('ADDRESS_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }
        $input = $request->validate([
            'title' => ['filled','string','max:255',],
            'address' => ['filled','string','max:255',],
            'city' => ['filled','string','max:255',],
            'state' => ['filled','string','max:255',],
            'area' => ['filled','string','max:255',],
            'latitude' => ['filled','numeric',],
            'longitude' => ['filled','numeric',]
        ]);

        Addresses::whereId($id)->update($input);

        return $this->success([], Response::HTTP_OK, trans('ADDRESSS_UPDATED'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  string  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy(string $id)
    {
        $check_brand = Addresses::whereId($id)->first();
        if (!$check_brand) {
            return $this->error(trans('ADDRESS_NOT_FOUND'), Response::HTTP_NOT_FOUND);
        }

        $check_brand->delete();

        return $this->success([], Response::HTTP_OK, trans('ADDRESS_DELETED'));
    }

}

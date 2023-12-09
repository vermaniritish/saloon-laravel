<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;
use App\Http\Resources\BrandsResource;

class ProductsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'product_name' => $this->product_name,
            'product_description' => $this->product_description,
            'product_categories' => $this->product_categories,
            'image_path' => $this->image_path,
            'image_name' => $this->image_name,
            'price' => $this->price,
            'sale_price' => $this->sale_price,
            'created_at' =>  Carbon::createFromDate($this->created_at)->toDateTimeString(),
            'updated_at' =>  Carbon::createFromDate($this->updated_at)->toDateTimeString(),
            'brand' =>  new BrandsResource($this->brand)
    ];
    }
}

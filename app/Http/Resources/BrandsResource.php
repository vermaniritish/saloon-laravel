<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;
use App\Http\Resources\ProductsResource;

class BrandsResource extends JsonResource
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
                'id'   =>  $this->id,
                'brand_name' =>  $this->brand_name,
                'brand_description' =>  $this->brand_description,
                'image_path' =>  $this->image_path,
                'image_name' =>  $this->image_name,
                'created_at' =>  Carbon::createFromDate($this->created_at)->toDateTimeString(),
                'updated_at' =>  Carbon::createFromDate($this->updated_at)->toDateTimeString(),
                'products' => $this->products
        ];
    }
}

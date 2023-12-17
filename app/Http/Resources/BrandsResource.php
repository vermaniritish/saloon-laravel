<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

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
                'title' =>  $this->title,
                'description' =>  $this->description,
                'image' =>  $this->image,
                'created' =>  Carbon::createFromDate($this->created)->toDateTimeString(),
                'modified' =>  Carbon::createFromDate($this->modified)->toDateTimeString(),
                'products' => $this->products
        ];
    }
}

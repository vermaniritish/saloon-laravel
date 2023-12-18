<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class CouponsResource extends JsonResource
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
                'coupon_code' =>  $this->coupon_code,
                'title' =>  $this->title,
                'description' =>  $this->description,
                'max_use' =>  $this->max_use,
                'used' => $this->used,
                'end_date' =>$this->end_date,
                'created' =>  Carbon::createFromDate($this->created)->toDateTimeString(),
                'modified' =>  Carbon::createFromDate($this->modified)->toDateTimeString()
        ];
    }
}

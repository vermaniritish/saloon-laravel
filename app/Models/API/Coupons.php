<?php

namespace App\Models\API;

use App\Models\AppModel;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Coupons extends AppModel
{
    use HasFactory;


    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'coupons';

    /**
     * The attributes that are not assignable.
     *
     * @var bool
     */
    protected $guarded = [];

    /**
     * Indicates if the model should be timestamped.
     *
     * @var bool
     */
    public $timestamps = true;

    /**
     * The primary key for the model.
     *
     * @var string
     */
    protected $primaryKey = 'id';

    /**
     * Get the indexable data array for the model.
     *
     * @return array
     */
    public function toSearchableArray()
    {
        return [
            'id',
            'coupon_code',
            'title',
            'description',
            'max_use'
        ];
    }

    public function scopeExpired($query)
    {       
        return $query->where('end_date', '>=', Carbon::now()->toDateString());
    }

    public function scopeUsageExceeded($query)
    {
        $query->whereRaw('(used < max_use)');
    }
}

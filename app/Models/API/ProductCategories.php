<?php

namespace App\Models\API;

use App\Models\Admin\ProductCategories as AdminProductCategories;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;

class ProductCategories extends AdminProductCategories
{
    /**
    * Get resize images
    *
    * @return array
    */
    public function getImageAttribute($value)
    {
        return $value ? FileSystem::getAllSizeImages($value) : null;
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
        $orderBy = $request->get('sort') ? $request->get('sort') : 'product_categories.title';
        $direction = $request->get('direction') ? $request->get('direction') : 'asc';
        $page = $request->get('page') ? $request->get('page') : 1;
        $limit = 10;
        $offset = ($page - 1) * $limit;
        
        $listing = ProductCategories::select([
                'product_categories.id',
                'product_categories.title',
                'product_categories.slug',
                'product_categories.image'
            ])
            ->orderBy($orderBy, $direction);

        if(!empty($where))
        {
            foreach($where as $query => $values)
            {
                if(is_array($values))
                    $listing->whereRaw($query, $values);
                elseif(!is_numeric($query))
                    $listing->where($query, $values);
                else
                    $listing->whereRaw($values);
            }
        }
        
        // Put offset and limit in case of pagination
        if($page !== null && $page !== "" && $limit !== null && $limit !== "")
        {
            $listing->offset($offset);
            $listing->limit($limit);
        }

        $listing = $listing->paginate($limit);

        return $listing;
    }
}
<?php

namespace App\Models\Admin;

use App\Models\AppModel;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Libraries\FileSystem;
use Illuminate\Support\Str;
use App\Libraries\General;

class Staff extends AppModel
{
    protected $table = 'staff';
    protected $primaryKey = 'id';
    public $timestamps = false;

    /**** ONLY USE FOR MAIN TALBLES NO NEED TO USE FOR RELATION TABLES OR DROPDOWNS OR SMALL SECTIONS ***/
    use SoftDeletes;

    /**
    * Get resize images
    *
    * @return array
    */
    public function getResizeImagesAttribute()
    {
        return $this->image ? FileSystem::getAllSizeImages($this->image) : null;
    }

    /**
    * Products -> Admins belongsTO relation
    * 
    * @return Admins
    */
    public function owner()
    {
        return $this->belongsTo(Admins::class, 'created_by', 'id');
    }

    /**
     * Define a one-to-many relationship.
     *
     * @return \Illuminate\Database\Eloquent\Relations\HasMany
     */
    public function staffDoc()
    {
        return $this->hasMany(StaffDocuments::class,'staff_id');
    }

    /**
    * To search and get pagination listing
    * @param Request $request
    * @param $limit
    */

    public static function getListing(Request $request, $where = [])
    {
    	$orderBy = $request->get('sort') ? $request->get('sort') : 'staff.id';
    	$direction = $request->get('direction') ? $request->get('direction') : 'desc';
    	$page = $request->get('page') ? $request->get('page') : 1;
    	$limit = self::$paginationLimit;
    	$offset = ($page - 1) * $limit;
    	
        $listing = Staff::select([
            'staff.*',
            'owner.first_name as owner_first_name',
            'owner.last_name as owner_last_name'
        ])
        ->leftJoin('admins as owner', 'owner.id', '=', 'staff.created_by')
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

    /**
    * To get all records
    * @param $where
    * @param $orderBy
    * @param $limit
    */
    public static function getAll($select = [], $where = [], $orderBy = 'staff.id desc', $limit = null)
    {
    	$listing = Staff::orderByRaw($orderBy);

    	if(!empty($select))
    	{
    		$listing->select($select);
    	}
    	else
    	{
    		$listing->select([
    			'staff.*'
    		]);	
    	}

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
	    
	    if($limit !== null && $limit !== "")
	    {
	    	$listing->limit($limit);
	    }

	    $listing = $listing->get();

	    return $listing;
    }

    /**
    * To get single record by id
    * @param $id
    */
    public static function get($id)
    {
    	$record = Staff::where('id', $id)
            ->with([
                'owner' => function($query) {
                    $query->select(['id', 'first_name', 'last_name', 'status']);
                },
            ])
            ->first();
            
	    return $record;
    }

    /**
    * To get single row by conditions
    * @param $where
    * @param $orderBy
    */
    public static function getRow($where = [], $orderBy = 'staff.id desc')
    {
    	$record = Staff::orderByRaw($orderBy);

	    foreach($where as $query => $values)
	    {
	    	if(is_array($values))
                $record->whereRaw($query, $values);
            elseif(!is_numeric($query))
                $record->where($query, $values);
            else
                $record->whereRaw($values);
	    }
	    
	    $record = $record->limit(1)->first();

	    return $record;
    }

    /**
    * To insert
    * @param $where
    * @param $orderBy
    */
    public static function create($data)
    {
    	$staff = new Staff();

    	foreach($data as $k => $v)
    	{
    		$staff->{$k} = $v;
    	}

        $staff->created_by = AdminAuth::getLoginId();
    	$staff->created = date('Y-m-d H:i:s');
    	$staff->modified = date('Y-m-d H:i:s');
	    if($staff->save())
	    {
	    	return $staff;
	    }
	    else
	    {
	    	return null;
	    }
    }


    /**
    * To update
    * @param $id
    * @param $where
    */
    public static function modify($id, $data)
    {
    	$staff = Staff::find($id);
    	foreach($data as $k => $v)
    	{
    		$staff->{$k} = $v;
    	}

    	$staff->modified = date('Y-m-d H:i:s');
	    if($staff->save())
	    {
            if(isset($data['title']) && $data['title'])
            {
                $staff->slug = Str::slug($staff->title) . '-' . General::encode($staff->id);
                $staff->save();
            }

	    	return $staff;
	    }
	    else
	    {
	    	return null;
	    }
    }

    
    /**
    * To update all
    * @param $id
    * @param $where
    */
    public static function modifyAll($ids, $data)
    {
    	if(!empty($ids))
    	{
    		return Staff::whereIn('staff.id', $ids)
		    		->update($data);
	    }
	    else
	    {
	    	return null;
	    }

    }

    /**
    * To delete
    * @param $id
    */
    public static function remove($id)
    {
    	$staff = Staff::find($id);
        $images = $staff->getResizeImagesAttribute();
    	if($staff->delete())
        {
            foreach($images as $img)
            {
                foreach($img as $i)
                {
                    if($i && is_dir(public_path($i)) && file_exists(public_path($i)))
                    {
                        unlink(public_path($i));
                    }
                }
            }
            return true;
        }
        else
        {
            return false;
        }
    }

    /**
    * To delete all
    * @param $id
    * @param $where
    */
    public static function removeAll($ids)
    {
    	if(!empty($ids))
    	{
    		foreach($ids as $id)
            {
                Staff::remove($id);
            }

            return true;
	    }
	    else
	    {
	    	return null;
	    }

    }
}
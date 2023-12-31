<?php
namespace App\Models\Admin;

use App\Models\AppModel;

class OrderProductRelation extends AppModel
{
    protected $table = 'order_products';
    protected $primaryKey = 'id';
    public $timestamps = false;
}

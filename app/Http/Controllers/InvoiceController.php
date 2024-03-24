<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Admin\Orders;
use Illuminate\Http\Response;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;

class InvoiceController extends Controller
{
    public function pdf(Request $request, $orderId)
    {
        return view("invoice", [

        ]);
    }
}
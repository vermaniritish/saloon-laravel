<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\BrandsController;
use App\Http\Controllers\ProductsController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['guest:api'])->group(function () {
    include "API/auth.php";
    include "API/home.php";
    include "API/products.php";

});

Route::middleware(['apiAuth'])->group(function () {
    include "API/users.php";
    // include "API/wishlist.php";
    // include "API/messages.php";
});


// Route::apiResources(
//     [
//     'brands' => BrandsController::class,
//     'products' => ProductsController::class
//     ]
// );

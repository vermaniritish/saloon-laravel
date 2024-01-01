<?php

use App\Http\Controllers\Admin\OrderCommentsController;
use App\Http\Controllers\Admin\OrdersController;

Route::get('/order', [OrdersController::class, 'index'])
    ->name('admin.orders');

Route::get('/order/add', [OrdersController::class, 'add'])
    ->name('admin.orders.add');

Route::post('/order/add', [OrdersController::class, 'add'])
    ->name('admin.orders.add');

Route::get('/order/{id}/view', [OrdersController::class, 'view'])
    ->name('admin.orders.view');

Route::get('/order/{id}/edit', [OrdersController::class, 'edit'])
    ->name('admin.orders.edit');

Route::post('/order/{id}/edit', [OrdersController::class, 'edit'])
    ->name('admin.orders.edit');

Route::post('/order/bulkActions/{action}', [OrdersController::class, 'bulkActions'])
    ->name('admin.orders.bulkActions');

Route::get('/order/{id}/delete', [OrdersController::class, 'delete'])
    ->name('admin.orders.delete');

Route::get('/order/{id}/comments', [OrderCommentsController::class, 'index'])->name('admin.orderComments');
Route::post('/order/{id}/comments', [OrderCommentsController::class, 'add'])->name('admin.orderComments.add');
Route::post('/order/{id}/update-comments', [OrderCommentsController::class, 'edit'])->name('admin.orderComments.edit');
Route::post('/order/{id}/delete-comment', [OrdersController::class, 'delete'])->name('admin.orderComments.delete');
<?php 
Route::get('/settings', '\App\Http\Controllers\Admin\SettingsController@index')
    ->name('admin.settings');

Route::post('/settings', '\App\Http\Controllers\Admin\SettingsController@index')
    ->name('admin.settings');

Route::post('/settings/email', '\App\Http\Controllers\Admin\SettingsController@email')
    ->name('admin.settings.email');

Route::post('/settings/recaptcha', '\App\Http\Controllers\Admin\SettingsController@recaptcha')
    ->name('admin.settings.recaptcha');

Route::post('/settings/date-time-formats', '\App\Http\Controllers\Admin\SettingsController@dateTimeFormats')
    ->name('admin.settings.dateTimeFormats');

Route::get('/settings/home', '\App\Http\Controllers\Admin\SettingsController@home')
    ->name('admin.settings.home');

Route::post('/settings/home', '\App\Http\Controllers\Admin\SettingsController@home')
    ->name('admin.settings.home');

Route::get('/settings/footer-links', '\App\Http\Controllers\Admin\SettingsController@footerLinks')
    ->name('admin.settings.footerLinks');
    
Route::post('/settings/footer-links', '\App\Http\Controllers\Admin\SettingsController@footerLinks')
    ->name('admin.settings.footerLinks');

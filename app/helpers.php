<?php
use App\Models\Admin\Settings;
use Illuminate\Support\Carbon;

function _dt($datetime)
{
	$dateFormat = Settings::get('date_format');
	$timeFormat = Settings::get('time_format');

	return date($dateFormat . ' ' . $timeFormat, strtotime($datetime));
}

function _d($date)
{
	$dateFormat = Settings::get('date_format');
	return date($dateFormat, strtotime($date));
}

function _time($time)
{
	$timeFormat = Settings::get('time_format');
	return date($timeFormat, strtotime($time));
}

function time_ago($time)
{
	$date = new Carbon($time);
    return $date->diffForHumans();
}

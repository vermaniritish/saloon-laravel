<?php

namespace App\Traits;

use Spatie\Activitylog\Contracts\Activity;

trait LogsCauserInfo {
	public function tapActivity(Activity $activity, string $eventName) {
		$activity->properties = $activity->properties->merge(
			[
				'ip' => request()->getClientIp()
			]
		);
	}
}

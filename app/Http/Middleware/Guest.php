<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Admin\Activities;
use App\Libraries\General;

class Guest
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $data =  !empty($request->toArray()) ? json_encode($request->toArray()) : null;
        $data = $data ? General::encrypt($data) : null;
        Activities::create([
            'url' => url()->current(),
            'data' => $data,
            'admin' => null,
            'client' => null,
            'ip' => $request->getClientIp()
        ]);
        return $next($request)
        ->header('Access-Control-Allow-Origin', '*')
        ->header('Access-Control-Allow-Methods', '*')
        ->header('Access-Control-Allow-Credentials', true)
        ->header('Access-Control-Allow-Headers', 'X-Requested-With,Content-Type,X-Token-Auth,Authorization')
        ->header('Accept', 'application/json');;
    }
}

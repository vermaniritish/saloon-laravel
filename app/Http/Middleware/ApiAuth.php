<?php

namespace App\Http\Middleware;
use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Closure;
use Illuminate\Support\Facades\Auth;
use App\Models\API\ApiAuth as ApiAuthModal;
use App\Models\Admin\Activities;
use App\Libraries\General;

class ApiAuth extends Middleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */

    public function handle($request, Closure $next, ...$guards)
    {
        $clientId = ApiAuthModal::getLoginId();
        $clientId = $clientId ? $clientId : null;
        Activities::log($request, null, $clientId);

        if($clientId)
        {
            ApiAuthModal::updateToken();
            return $next($request);
        }
        else
        {
            return Response()->json([
                    'status' => false,
                    'message' => 'Session Expired.'
                ], 403);
        }
    }
}

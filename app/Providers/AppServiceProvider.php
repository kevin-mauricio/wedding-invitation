<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        if (!is_dir(base_path('bootstrap/cache'))) {
            mkdir(base_path('bootstrap/cache'), 0775, true);
        }

        if (env('APP_ENV') === 'production') {
            URL::forceScheme('https');
        }
    }
}

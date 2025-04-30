<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RsvpController;

Route::get('/', [RsvpController::class, 'index']);
Route::post('/confirmar', [RsvpController::class, 'store']);
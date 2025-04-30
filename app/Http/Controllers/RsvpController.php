<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class RsvpController extends Controller
{
    public function index() {
        return view('invitacion');
    }
    
    public function store(Request $request) {
        Rsvp::create($request->only('nombre', 'asistencia'));
        return view('gracias', ['nombre' => $request->nombre]);
    }
    
}

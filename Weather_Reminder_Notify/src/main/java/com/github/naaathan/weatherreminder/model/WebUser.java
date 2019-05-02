package com.github.naaathan.weatherreminder.model;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public final class WebUser {

    public final int id;
    public final String device_token;
    public final String email;

}

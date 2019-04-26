package com.github.naaathan.weatherreminder.model;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public final class Event {

    @RequiredArgsConstructor
    public static class Period {

        public final long startDate;
        public final long endDate;

    }

    @RequiredArgsConstructor
    public static class Location {

        public final double longitude;
        public final double lat;

    }

    public final int id;
    public final int user_id;
    public final String title;
    public final Period period;
    public final int alertDays;
    public final String remindTime;
    public final String sunny;
    public final String cloudy;
    public final String windy;
    public final String rainy;
    public final String snow;
    public final double uvIndex;
    public final double humidity;
    public final Location loc;

}

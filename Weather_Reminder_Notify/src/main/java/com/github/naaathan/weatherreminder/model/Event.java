package com.github.naaathan.weatherreminder.model;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class Event {

    @RequiredArgsConstructor
    public static class Period {

        public final String startDate;
        public final String endDate;

    }

    @RequiredArgsConstructor
    public static class Location {

        public final String lon;
        public final String lat;

    }

    public final int id;
    public final String title;
    public final Period period;
    public final int alertDays;
    public final String remindTime;
    public final String sunny;
    public final String cloudy;
    public final String windy;
    public final String rainy;
    public final String snow;
    public final String uvIndex;
    public final String humidity;
    public final Location loc;
    public final String locName;

    public boolean isComplete() {
        return id > 0 && title != null && period != null && alertDays > -1 && remindTime != null && sunny != null &&
                cloudy != null && windy != null && rainy != null && snow != null && uvIndex != null && humidity != null && loc != null && locName != null;
    }

}

package com.github.naaathan.weatherreminder.model;

public final class WebEvent extends Event {

    public final int user_id;

    public WebEvent(Event event, int user_id) {
        super(event.id, event.title, event.period, event.alertDays, event.remindTime, event.sunny, event.cloudy, event.windy, event.rainy, event.snow, event.uvIndex, event.humidity, event.loc);
        this.user_id = user_id;
    }
}

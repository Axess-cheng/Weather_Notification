package com.github.naaathan.weatherreminder.timer;

import com.github.naaathan.weatherreminder.model.Event;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EventListTimer extends Timer {

    private Map<Integer, List<Event>> events;

    public EventListTimer(long interval) {
        super(interval, -1);
    }

    @Override
    public void tick() {
        Map<Integer, List<Event>> events = new HashMap<>();
    }

}

package com.github.naaathan.weatherreminder.timer;

import com.github.naaathan.weatherreminder.WeatherReminder;
import com.github.naaathan.weatherreminder.model.Event;
import com.github.naaathan.weatherreminder.model.WebEvent;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class EventListTimer extends Timer {

    public EventListTimer(long interval) {
        super(interval, -1);
    }

    @Override
    public void tick() {
        Map<Integer, Map<Integer, Event>> events = new HashMap<>();
        String urlString = WeatherReminder.DB_REQUEST_URL + "get_events.php";
        String parameters = "token=" + WeatherReminder.SUPERUSER_TOKEN + "&user_id=" + WeatherReminder.SUPERUSER_ID;

        try {
            String response = WeatherReminder.getInstance().sendWebRequest("GET", urlString, parameters, false);

            if ("".equals(response)) {
                return;
            }

            WebEvent[] eventsResponse = WeatherReminder.GSON.fromJson(response, WebEvent[].class);

            for (WebEvent event : eventsResponse) {
                if (event.user_id <= 0 || !event.isComplete()) {
                    continue;
                }

                Map<Integer, Event> userEvents = events.getOrDefault(event.user_id, new HashMap<>());

                userEvents.put(event.id, new Event(event.id, event.title, event.period, event.alertDays, event.remindTime, event.sunny, event.cloudy, event.windy, event.rainy, event.snow, event.uvIndex, event.humidity, event.loc));
                events.put(event.user_id, userEvents);
            }
        } catch (IOException e) {
            WeatherReminder.getLogger().severe("EVENTLISTTIMER TICK EXCEPTION:");
            e.printStackTrace();
        }

        WeatherReminder.getInstance().getEventTimer().setEvents(events);
    }

}

package com.github.naaathan.weatherreminder.timer;

import com.github.naaathan.weatherreminder.WeatherReminder;
import lombok.Getter;

public abstract class Timer {

    private long interval;
    @Getter
    private boolean running;
    private int ticks;

    public Timer(long interval, int ticks) {
        this.interval = interval;
        this.running = false;
        this.ticks = ticks;
    }

    public abstract void tick();

    public final void start() {
        if (running) {
            return;
        }

        running = true;
        new Thread(this::run).start();
    }

    public final void stop() {
        if (!running) {
            return;
        }

        running = false;
    }

    private void run() {
        while (running) {
            if (ticks == 0) {
                break;
            }

            if (ticks > 0) {
                ticks--;
            }

            try {
                tick();
            } catch (Exception e) {
                WeatherReminder.getLogger().severe("TICK EXCEPTION:");
                e.printStackTrace();
            }

            try {
                Thread.sleep(interval);
            } catch (InterruptedException e) {
            }
        }

        running = false;
    }

}

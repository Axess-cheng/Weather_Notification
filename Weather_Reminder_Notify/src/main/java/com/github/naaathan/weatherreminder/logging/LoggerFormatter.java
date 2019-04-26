package com.github.naaathan.weatherreminder.logging;

import java.util.Date;
import java.util.logging.LogRecord;
import java.util.logging.SimpleFormatter;

public final class LoggerFormatter extends SimpleFormatter {

    @Override
    public synchronized String format(LogRecord record) {
        return String.format("[%1$tF %1$tT] %2$s: %3$s %n", new Date(record.getMillis()), record.getLevel().getLocalizedName(), record.getMessage());
    }

}

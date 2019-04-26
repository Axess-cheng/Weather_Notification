package com.github.naaathan.weatherreminder;

import com.github.naaathan.weatherreminder.logging.LoggerFormatter;
import com.notnoop.apns.APNS;

import lombok.AccessLevel;
import lombok.Getter;

import java.util.Scanner;
import java.util.logging.ConsoleHandler;
import java.util.logging.Logger;

public final class WeatherReminderApp {

    @Getter(AccessLevel.PACKAGE)
    private static Logger logger;

    public static void main(String[] args) {
        setLogger(Logger.getLogger("WeatherReminderApp"));
        WeatherReminder.getInstance();

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            WeatherReminder.getInstance().shutdown();
        }));

        String next;
        Scanner scanner = new Scanner(System.in);

        logger.info("Enter 'q' or 'quit' to exit...");
        System.out.print("> ");

        while ((next = scanner.nextLine()) != null) {
            boolean executed = false;

            if (next.toLowerCase().startsWith("notify ")) {
                next = next.replace("notify ", "");

                if (next.equalsIgnoreCase("production")) {
                    executed = true;
                    notifyHandle(scanner, false);
                } else if (next.equalsIgnoreCase("sandbox")) {
                    executed = true;
                    notifyHandle(scanner, true);
                }
            }

            if (next.toLowerCase().equals("q") || next.toLowerCase().equals("quit")) {
                break;
            }

            if (!executed) {
                logger.warning("Invalid command!");
            }

            System.out.print("> ");
        }

        logger.info("Shutting down...");
        System.exit(0);
    }

    private static void notifyHandle(Scanner scanner, boolean sandbox) {
        System.out.println("Please type 'q' to exit this process at any time!");
        System.out.print("Please enter an alert body: ");

        String body;
        String token;

        if (toQuit(body = scanner.nextLine())) {
            return;
        }

        System.out.print("Please enter a device token: ");

        if (toQuit(token = scanner.nextLine())) {
            return;
        }

        String payload = APNS.newPayload().alertBody(body).build();

        WeatherReminder.getInstance().sendPushNotification(sandbox, payload, token);
        logger.info("Notification payload pushed!");
    }

    private static void setLogger(Logger logger) {
        ConsoleHandler handler = new ConsoleHandler();

        handler.setFormatter(new LoggerFormatter());
        logger.addHandler(handler);
        logger.setUseParentHandlers(false);

        WeatherReminderApp.logger = logger;
    }

    private static boolean toQuit(String string) {
        return string.equalsIgnoreCase("q");
    }

}

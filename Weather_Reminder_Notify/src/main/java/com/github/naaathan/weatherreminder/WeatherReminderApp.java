package com.github.naaathan.weatherreminder;

import com.github.naaathan.weatherreminder.logging.LoggerFormatter;
import com.notnoop.apns.APNS;

import lombok.AccessLevel;
import lombok.Getter;

import java.io.IOException;
import java.util.Scanner;
import java.util.TimeZone;
import java.util.logging.ConsoleHandler;
import java.util.logging.Logger;

public final class WeatherReminderApp {

    @Getter(AccessLevel.PACKAGE)
    private static Logger logger;

    public static void main(String[] args) {
        setLogger(Logger.getLogger("WeatherReminderApp"));
        TimeZone.setDefault(TimeZone.getTimeZone(WeatherReminder.TIME_ZONE));
        WeatherReminder.getInstance();

        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            WeatherReminder.getInstance().shutdown();
        }));

        String next;
        Scanner scanner = new Scanner(System.in);

        logger.info("Enter 'q' or 'quit' to exit...");

        while ((next = scanner.nextLine()) != null) {
            boolean executed = false;

            if (next.toLowerCase().startsWith("notify ")) {
                next = next.replace("notify ", "");

                if (next.equalsIgnoreCase("production")) {
                    executed = true;
                    handleNotify(scanner, false);
                } else if (next.equalsIgnoreCase("sandbox")) {
                    executed = true;
                    handleNotify(scanner, true);
                }
            } else if (next.equalsIgnoreCase("request")) {
                executed = true;
                handleRequest(scanner);
            }

            if (next.toLowerCase().equals("q") || next.toLowerCase().equals("quit")) {
                break;
            }

            if (!executed) {
                logger.warning("Invalid command!");
            }
        }

        logger.info("Shutting down...");
        System.exit(0);
    }

    private static void handleNotify(Scanner scanner, boolean sandbox) {
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
    }

    private static void handleRequest(Scanner scanner) {
        System.out.println("Please type 'q' to exit this process at any time!");

        String method;
        String url;
        String parameters;

        do {
            System.out.print("Please enter a request method: ");

            if (toQuit(method = scanner.nextLine())) {
                return;
            }
        } while (!method.equalsIgnoreCase("get") && !method.equalsIgnoreCase("post"));

        System.out.print("Please enter a URL: ");

        if (toQuit(url = scanner.nextLine())) {
            return;
        }

        System.out.print("Please enter the parameters: ");

        if (toQuit(parameters = scanner.nextLine())) {
            return;
        }

        try {
            WeatherReminder.getInstance().sendWebRequest(method, url, parameters, true);
        } catch (IOException e) {
            logger.warning("Web request failed: " + e.getMessage());
        }
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

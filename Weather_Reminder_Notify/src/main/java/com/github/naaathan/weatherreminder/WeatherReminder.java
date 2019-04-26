package com.github.naaathan.weatherreminder;

import com.github.naaathan.weatherreminder.timer.EventListTimer;
import com.github.naaathan.weatherreminder.timer.EventTimer;
import com.notnoop.apns.APNS;
import com.notnoop.apns.ApnsService;
import com.notnoop.apns.ApnsServiceBuilder;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.logging.Logger;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public final class WeatherReminder {

    public static final String APPLE_CERT_PATH = "C:\\Users\\Nathan\\Downloads\\certification.p12";
    public static final String APPLE_CERT_PASSWORD = "123Certification";

    public static final String REQUEST_URL = "http://142.93.34.33/";
    public static final int SUPERUSER_ID = 0;
    public static final String SUPERUSER_TOKEN = "XvgcNiTgSPABTVqf";

    private static final long EVENT_INTERVAL = 300000L;
    private static final long EVENT_LIST_INTERVAL = 5000L;

    private static WeatherReminder instance;

    private EventListTimer eventListTimer;
    private EventTimer eventTimer;

    public static WeatherReminder getInstance() {
        if (instance == null) {
            instance = new WeatherReminder();
            instance.init();
        }

        return instance;
    }

    public static Logger getLogger() {
        return WeatherReminderApp.getLogger();
    }

    public void sendPushNotification(boolean sandbox, String payload, String token) {
        ApnsServiceBuilder builder = APNS.newService()
                .withCert(WeatherReminder.APPLE_CERT_PATH, WeatherReminder.APPLE_CERT_PASSWORD);

        if (sandbox) {
            builder.withSandboxDestination();
        } else {
            builder.withAppleDestination(true);
        }

        getLogger().info("Sending push notification:");
        getLogger().info("Payload: " + payload);
        getLogger().info("Token: " + token);

        ApnsService service = builder.build();

        service.push(token, payload);
        getLogger().info("Push notification sent!");
    }

    public String sendWebRequest(String method, String urlString, String parameters) throws IOException {
        if (!method.equals("GET") && !method.equals("POST")) {
            return null;
        }

        WeatherReminder.getLogger().info("Opening connection for " + method + " request:");
        WeatherReminder.getLogger().info("URL: " + urlString);
        WeatherReminder.getLogger().info("Parameters: " + parameters);

        if (method.equals("GET")) {
            urlString += "?" + parameters;
        }

        URL url = new URL(urlString);
        HttpURLConnection http = (HttpURLConnection) url.openConnection();

        http.setRequestMethod(method);
        http.setRequestProperty("User-Agent", "Mozilla/5.0");
        http.setDoOutput(true);

        if (method.equals("POST")) {
            OutputStream out = http.getOutputStream();

            out.write(parameters.getBytes());
            out.flush();
            out.close();
        }

        WeatherReminder.getLogger().info(method + " parameters pushed");

        StringBuffer response = new StringBuffer();
        int responseCode = http.getResponseCode();

        WeatherReminder.getLogger().info(method + " response code: " + responseCode);

        if (responseCode == HttpURLConnection.HTTP_OK) {
            BufferedReader in = new BufferedReader(new InputStreamReader(http.getInputStream()));
            String inputLine;

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }

            in.close();
        } else {
            WeatherReminder.getLogger().warning(method + " request failed");
        }

        WeatherReminder.getLogger().info(method + " response: " + response.toString());
        WeatherReminder.getLogger().info(method + " request complete");

        return response.toString();
    }

    public void shutdown() {
        eventListTimer.stop();
        eventTimer.stop();
    }

    private void init() {
        (eventListTimer = new EventListTimer(EVENT_LIST_INTERVAL)).start();
        (eventTimer = new EventTimer(EVENT_INTERVAL)).start();
    }

}

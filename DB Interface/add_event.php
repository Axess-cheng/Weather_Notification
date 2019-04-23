<?php

include_once "functions/generic_functions.php";
include_once "functions/mongo_functions.php";
include_once "functions/sql_functions.php";
include_once "include/config.php";
include_once "include/mongo_connector.php";
include_once "include/mysql_connector.php";

if (!isset($_POST["event"]) || !isset($_POST["token"]) || !isset($_POST["user_id"])) {
    echo json_encode(
        array(
            "error" => "Invalid parameters"
        )
    );
    return;
}

$token = $_POST["token"];
$user_id = $_POST["user_id"];

if (!validate_token($mysql, "tokens", $user_id, $token)) {
    echo json_encode(
        array(
            "error" => "Invalid token"
        )
    );
    return;
}

$event = json_decode($_POST["event"]);
$event_id = add_event(get_collection($mongodb, "events"), get_collection($mongodb, "counters"), $event);

if ($event_id > 0) {
    $event["id"] = $event_id;

    add_event_link($mysql, "users_events", $user_id, $event_id);
    echo json_encode($event);
} else {
    echo json_encode(
        array(
            "error" => "Event creation failed"
        )
    );
}
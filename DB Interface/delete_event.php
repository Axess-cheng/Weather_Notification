<?php

require_once __DIR__ . "/vendor/autoload.php";

include_once "include/config.php";
include_once "include/mongo_connector.php";
include_once "include/mysql_connector.php";
include_once "functions/generic_functions.php";
include_once "functions/mongo_functions.php";
include_once "functions/sql_functions.php";

if (!isset($_POST["event_id"]) || !isset($_POST["token"]) || !isset($_POST["user_id"])) {
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

$event_id = $_POST["event_id"];

if ($user_id != 0) {
    $users_event_ids = get_event_ids($mysql, "users_events", $user_id);

    if (!in_array($event_id, $users_event_ids)) {
        echo json_encode(
            array(
                "error" => "User event not found"
            )
        );
        return;
    }
}

$event = get_event(get_collection($mongo, $_CONFIG["mongo"]["database"], "events"), $event_id);

if ($event == null) {
    echo json_encode(
        array(
            "error" => "Invalid event ID"
        )
    );
    return;
}

if (delete_event(get_collection($mongo, $_CONFIG["mongo"]["database"], "events"), $mysql, $event_id, "users_events")) {
    echo json_encode(
        array(
            "success" => "Event deleted"
        )
    );
} else {
    echo json_encode(
        array(
            "error" => "Event deletion failed"
        )
    );
}
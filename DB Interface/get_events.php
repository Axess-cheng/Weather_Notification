<?php

require_once __DIR__ . "/vendor/autoload.php";

include_once "include/config.php";
include_once "include/mongo_connector.php";
include_once "include/mysql_connector.php";
include_once "functions/generic_functions.php";
include_once "functions/mongo_functions.php";
include_once "functions/sql_functions.php";

if (!isset($_GET["token"]) || !isset($_GET["user_id"])) {
    echo json_encode(
        array(
            "error" => "Invalid parameters"
        )
    );
    return;
}

$token = $_GET["token"];
$user_id = $_GET["user_id"];

if (!validate_token($mysql, "tokens", $user_id, $token)) {
    echo json_encode(
        array(
            "error" => "Invalid token"
        )
    );
    return;
}

echo json_encode(
    get_events(get_collection($mongo, $_CONFIG["mongo"]["database"], "events"), $mysql, "users_events", $user_id)
);

<?php

include_once "include/config.php";
include_once "functions/reminder_functions.php";

if (!isset($_GET["event"])) {
    echo json_encode(
        array(
            "error" => "Invalid parameters"
        )
    );
    return;
}

$event = $_GET["event"];

echo reqAlert($event);
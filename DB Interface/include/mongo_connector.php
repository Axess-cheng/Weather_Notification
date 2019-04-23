<?php

$options = array("connect" => TRUE, "username" => $_CONFIG["mongo"]["username"]);

if ($_CONFIG["mongo"]["password"] !== "") {
    $options["password"] = $_CONFIG["mongo"]["password"];
}

try {
    $mongo = new MongoClient("mongodb://" . $_CONFIG["mongo"]["host"] . ":" . $_CONFIG["mongo"]["port"], $options);
} catch (MongoConnectionException $e) {
    die("Connection error: " . $e->getMessage());
}

$mongodb = $mongo->selectDB($_CONFIG["mongo"]["database"]);
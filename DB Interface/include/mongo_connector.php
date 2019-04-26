<?php

$options = array("connect" => TRUE);

if ($_CONFIG["mongo"]["user"] !== "") {
    $options["user"] = $_CONFIG["mongo"]["user"];
}

if ($_CONFIG["mongo"]["password"] !== "") {
    $options["password"] = $_CONFIG["mongo"]["password"];
}

try {
    $mongo = new MongoDB\Client("mongodb://" . $_CONFIG["mongo"]["host"] . ":" . $_CONFIG["mongo"]["port"], $options);
} catch (MongoConnectionException $e) {
    die("Mongo connection error: " . $e->getMessage());
}
<?php

require_once __DIR__ . "/vendor/autoload.php";

include_once "include/config.php";
include_once "include/mysql_connector.php";
include_once "functions/generic_functions.php";
include_once "functions/sql_functions.php";

if (!isset($_GET["id_field"]) || !isset($_GET["id_data"]) || !isset($_GET["id_type"]) || !isset($_GET["token"])) {
    echo json_encode(
        array(
            "error" => "Invalid parameters"
        )
    );
    return;
}

$token = $_GET["token"];

if (!validate_token($mysql, "tokens", 0, $token)) {
    echo json_encode(
        array(
            "error" => "Invalid token"
        )
    );
    return;
}

$id_field = $_GET["id_field"];
$id_data = $_GET["id_data"];
$id_type = $_GET["id_type"];
$user = get_user_result($mysql, "users", $id_field, $id_data, $id_type);

if ($user == null) {
    echo json_encode(
        array(
            "error" => "User does not exist"
        )
    );
    return;
}

unset($user["password"], $user["salt"]);
echo json_encode($user);
<?php

$mysql = new mysqli($_CONFIG["mysql"]["host"], $_CONFIG["mysql"]["username"], $_CONFIG["mysql"]["password"], $_CONFIG["mysql"]["database"], $_CONFIG["mysql"]["port"]);

if ($mysql->connect_error) {
    die("Connection error: " . $mysql->connect_error);
}
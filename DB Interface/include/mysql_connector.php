<?php

$mysql = new mysqli($_CONFIG["mysql"]["host"], $_CONFIG["mysql"]["user"], $_CONFIG["mysql"]["password"], $_CONFIG["mysql"]["database"], $_CONFIG["mysql"]["port"]);

if ($mysql->connect_error) {
    die("MySQL connection error: " . $mysql->connect_error);
}
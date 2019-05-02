<?php

function add_event_link(mysqli $connection, $user_events_table, $user_id, $event_id)
{
    $query = "INSERT INTO `" . $user_events_table . "` VALUES (?, ?);";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("ii", $user_id, $event_id);
        $stmt->execute();
    }
}

function add_user(mysqli $connection, $user_table, $device_token, $email, $password, $salt)
{
    $query = "INSERT INTO `" . $user_table . "` (`device_token`, `email`, `password`, `salt`) VALUES (?, ?, ?, ?);";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("ssss", $device_token, $email, $password, $salt);
        $stmt->execute();

        return true;
    }

    return false;
}

function get_user_result(mysqli $connection, $user_table, $id_field, $id_data, $id_type)
{
    $id_field = $connection->escape_string($id_field);
    $query = "SELECT * FROM `" . $user_table . "` WHERE `" . $id_field . "`=?;";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param($id_type, $id_data);
        $stmt->execute();

        $result = $stmt->get_result();

        if ($result->num_rows <= 0) {
            return null;
        }

        return $result->fetch_assoc();
    }

    return null;
}

function update_user_tokens(mysqli $connection, $token_table, $user_table, $user_id, $device_token, $token)
{
    $query = "UPDATE `" . $user_table . "` SET `device_token`=? WHERE `id`=?;";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("si", $device_token, $user_id);
        $stmt->execute();

        $query = "SELECT `token` FROM `" . $token_table . "` WHERE `user_id`=?;";
        $stmt = $connection->stmt_init();

        if ($stmt->prepare($query)) {
            $stmt->bind_param("i", $user_id);
            $stmt->execute();

            $result = $stmt->get_result();

            if ($result->num_rows > 0) {
                if ($result->fetch_assoc()["token"] === $token) {
                    return;
                }

                $stmt = $connection->stmt_init();
                $query = "UPDATE `" . $token_table . "` SET `token`=? WHERE `user_id`=?;";

                if ($stmt->prepare($query)) {
                    $stmt->bind_param("si", $token, $user_id);
                    $stmt->execute();
                }
            } else {
                $stmt = $connection->stmt_init();
                $query = "INSERT INTO `" . $token_table . "` VALUES (?, ?);";

                if ($stmt->prepare($query)) {
                    $stmt->bind_param("is", $user_id, $token);
                    $stmt->execute();
                }
            }
        }
    }
}

function validate_token(mysqli $connection, $token_table, $user_id, $token)
{
    $query = "SELECT `token` FROM `" . $token_table . "` WHERE `user_id`=?;";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();

        $result = $stmt->get_result();

        if ($result->num_rows <= 0) {
            return false;
        }

        return $result->fetch_assoc()["token"] === $token;
    }

    return false;
}
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

function add_user(mysqli $connection, $user_table, $email, $password, $salt)
{
    $query = "INSERT INTO `" . $user_table . "` (`email`, `password`, `salt`) VALUES (?, ?, ?);";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("sss", $email, $password, $salt);
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

function update_user_token(mysqli $connection, $token_table, $user_id, $token)
{
    $query = "SELECT `token` FROM `" . $token_table . "` WHERE `user_id`=?;";
    $stmt = $connection->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();

        $result = $stmt->get_result();
        $stmt = $connection->stmt_init();

        if ($result->num_rows > 0) {
            if ($result->fetch_assoc()["token"] === $token) {
                return;
            }

            $query = "UPDATE `" . $token_table . "` SET `token`=? WHERE `user_id`=?;";

            if ($stmt->prepare($query)) {
                $stmt->bind_param("si", $token, $user_id);
                $stmt->execute();
            }
        } else {
            $query = "INSERT INTO `" . $token_table . "` VALUES (?, ?);";

            if ($stmt->prepare($query)) {
                $stmt->bind_param("is", $user_id, $token);
                $stmt->execute();
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
}
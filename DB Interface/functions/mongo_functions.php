<?php

function add_event(MongoDB\Collection $event_collection, MongoDB\Collection $counters_collection, $event)
{
    if ($counters_collection->count(array("_id" => "eventid")) === 0) {
        try {
            $counters_collection->insertOne(array("_id" => "eventid", "value" => 0));
        } catch (Exception $e) {
            return -1;
        }
    }

    $document = $counters_collection->findOneAndUpdate(array("_id" => "eventid"), array("\$inc" => array("value" => 1)), array("new" => true));

    if ($document == null) {
        return -1;
    }

    $id = $document["value"];
    $event["_id"] = $id;

    if (isset($event["id"])) {
        unset($event["id"]);
    }

    try {
        $event_collection->insertOne($event);
    } catch (Exception $e) {
        return -1;
    }

    return $id;
}

function delete_event(MongoDB\Collection $collection, mysqli $mysql, $event_id, $user_events_table)
{
    $query = "DELETE FROM `" . $user_events_table . "` WHERE `event_id`=?;";
    $stmt = $mysql->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("i", $event_id);
        $stmt->execute();
    } else {
        return false;
    }

    try {
        $collection->deleteOne(array("_id" => $event_id));
        return true;
    } catch (Exception $e) {
        return false;
    }
}

function get_collection(MongoDB\Client $client, $database_name, $collection_name)
{
    return $client->selectCollection($database_name, $collection_name);
}

function get_event(MongoDB\Collection $collection, $event_id)
{
    $event = $collection->findOne(array("_id" => $event_id));

    if ($event != null) {
        $event["id"] = $event["_id"];

        unset($event["_id"]);
    }

    return $event;
}

function get_events(MongoDB\Collection $collection, mysqli $mysql, $user_events_table, $user_id)
{
    $events = array();
    $event_user_ids = get_event_ids($mysql, $user_events_table, $user_id);

    foreach ($event_user_ids as $user_id => $event_ids) {
        foreach ($event_ids as $event_id) {
            $event = get_event($collection, $event_id);

            if ($event != null) {
                $event["user_id"] = $user_id;

                array_push($events, $event);
            }
        }
    }

    return $events;
}

function get_event_ids(mysqli $mysql, $user_events_table, $user_id)
{
    $event_ids = array();

    if ($user_id != 0) {
        $query = "SELECT * FROM `" . $user_events_table . "` WHERE `user_id`=?;";
    } else {
        $query = "SELECT * FROM `" . $user_events_table . "`;";
    }

    $stmt = $mysql->stmt_init();

    if ($stmt->prepare($query)) {
        if ($user_id != 0) {
            $stmt->bind_param("i", $user_id);
        }

        $stmt->execute();

        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                if (!isset($event_ids[$row["user_id"]])) {
                    $event_ids[$row["user_id"]] = array();
                }

                array_push($event_ids[$row["user_id"]], $row["event_id"]);
            }
        }
    }

    return $event_ids;
}

function update_event(MongoDB\Collection $collection, $event_id, $event)
{
    try {
        return $collection->replaceOne(array("_id" => $event_id), $event)->isAcknowledged();
    } catch (Exception $e) {
    }

    return false;
}
<?php

function add_event(MongoCollection $event_collection, MongoCollection $counters_collection, array $event)
{
    if ($counters_collection->count(array("_id" => "eventid")) === 0) {
        try {
            $counters_collection->insert(array("_id" => "eventid", "value" => 0));
        } catch (Exception $e) {
            return -1;
        }
    }

    $document = $counters_collection->findAndModify(array("_id" => "eventid"), array("\$inc" => array("value" => 1)), null, array("new" => true));

    if ($document == null) {
        return -1;
    }

    $id = $document["value"];
    $event["_id"] = $id;

    try {
        $event_collection->insert($event);
    } catch (Exception $e) {
        return -1;
    }

    return $id;
}

function get_collection(MongoDB $database, $collection_name)
{
    try {
        return $database->selectCollection($collection_name);
    } catch (Exception $e) {
        return $database->createCollection($collection_name);
    }
}

function get_events(MongoCollection $collection, mysqli $mysql, $user_events_table, $user_id)
{
    $event_ids = get_event_ids($mysql, $user_events_table, $user_id);
    $events = array();

    foreach ($event_ids as $event_id) {
        $event = $collection->findOne(array("_id" => $event_id));
        $event["id"] = $event["_id"];

        unset($event["_id"]);
        array_push($events, $event);
    }

    return $events;
}

function get_event_ids(mysqli $mysql, $user_events_table, $user_id)
{
    $event_ids = array();
    $query = "SELECT `event_id` FROM `" . $user_events_table . "` WHERE `user_id`=?;";
    $stmt = $mysql->stmt_init();

    if ($stmt->prepare($query)) {
        $stmt->bind_param("i", $user_id);
        $stmt->execute();

        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                array_push($event_ids, $row["event_id"]);
            }
        }
    }

    return $event_ids;
}

function update_event(MongoCollection $collection, $event_id, $event)
{
    try {
        return $collection->update(array("_id" => $event_id), $event);
    } catch (Exception $e) {
    }

    return false;
}
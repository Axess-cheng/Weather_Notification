<?php

function generate_string($size, $chars = "ABCDEFHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890")
{
    if ($size <= 0) {
        return "";
    }

    $string = "";
    $chars_len = strlen($chars);

    for (; $size > 0; $size--) {
        $string .= $chars[rand(0, $chars_len - 1)];
    }

    return $string;
}

function hash_string($string, $salt = "")
{
    return hash("SHA256", hash("SHA256", $string) . $salt);
}
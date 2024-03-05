<?php
function compress_string($s) {
    $compressed_string = "";
    $current_char = $s[0];
    $count = 1;

    for ($i = 1; $i < strlen($s); $i++) {
        if ($s[$i] == $current_char) {
            $count++;
        } else {
            $compressed_string .= $current_char . $count;
            $current_char = $s[$i];
            $count = 1;
        }
    }

    $compressed_string .= $current_char . $count;

    return $compressed_string;
}

$input = 'p333pppwww777';
$output = compress_string($input);

echo $output;

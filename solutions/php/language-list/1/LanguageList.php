<?php

function language_list(...$items): array {    
    return $items;
}

function add_to_language_list(array $language_list, $language): array {
    array_push($language_list, $language);
    return $language_list;
}

function prune_language_list(array $language_list): array {
    array_splice($language_list, 0, 1);
    return $language_list;
}

function current_language(array $language_list) {
    return $language_list[0];
}

function language_list_length(array $language_list): int {
    return count($language_list);
}
<?php

class Utils {

    public static function alltrim($string) {
        $string = trim($string);

        do {
            $string = str_replace('  ', ' ', $string);
        } while (strpos($string, '  ') > 0);

        return $string;
    }

    public static function upper($string) {
        return mb_convert_case($string, MB_CASE_UPPER, 'UTF-8');
    }

    public static function lower($string) {
        return mb_convert_case($string, MB_CASE_LOWER, 'UTF-8');
    }

    public static function proper($string) {
        return mb_convert_case($string, MB_CASE_TITLE, 'UTF-8');
    }

}
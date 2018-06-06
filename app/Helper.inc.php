<?php

class Helper {
    
    public static function RemoveAccents($string) {
        $string = str_replace('á', '&#225;', $string);
        $string = str_replace('é', '&#233;', $string);
        $string = str_replace('í', '&#237;', $string);
        $string = str_replace('ó', '&#243;', $string);
        $string = str_replace('ú', '&#250;', $string);
        $string = str_replace('ñ', '&#241;', $string);

        return $string;
    }

}
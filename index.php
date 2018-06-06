<?php
session_start();

//include_once 'app/config.inc.php';

$url_components = parse_url($_SERVER['REQUEST_URI']);

$route = $url_components['path'];

$route_parts = explode('/', $route);
$route_parts = array_filter($route_parts);
$route_parts = array_slice($route_parts, 0);

$chosen_route = 'views/404.php';

if ($route_parts[0] == 'accounting') {
    if (count($route_parts) == 1) {
        $chosen_route = 'views/home.php';
    } else if (count($route_parts) == 2) {
        switch ($route_parts[1]) {
            case 'signin':
                $chosen_route = 'views/signin.php';
                break;
            case 'signout':
                $chosen_route = 'views/signout.php';
                break;
            case 'signup':
                $chosen_route = 'views/signup.php';
                break;
            case 'administration':
                $chosen_route = 'views/administration.php';
                break;
        }
    } else if (count($route_parts) == 3) {
        switch ($route_parts[1]) {
            case 'successful-signup':
                $name = $route_parts[2];
                $chosen_route = 'views/successful-signup.php';
                break;
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        $chosen_route = 'views/setup.php';
                        break;
                }
                break;
        }
    } else if (count($route_parts) == 4) {
        switch ($route_parts[1]) {
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        switch ($route_parts[3]) {
                            case 'general':
                                $chosen_route = 'views/general.php';
                                break;
                        }
                        break;
                }
                break;
        }
    } else if (count($route_parts) == 5) {
        switch ($route_parts[1]) {
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        switch ($route_parts[3]) {
                            case 'general':
                                switch ($route_parts[4]) {
                                    case 'country':
                                        $chosen_route = 'views/country-manager.php';
                                        break;
                                }
                                break;
                        }
                        break;
                }
                break;
        }
    } else if (count($route_parts) == 6) {
        switch ($route_parts[1]) {
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        switch ($route_parts[3]) {
                            case 'general':
                                switch ($route_parts[4]) {
                                    case 'country':
                                        switch ($route_parts[5]) {
                                            case 'new-country':
                                                $chosen_route = 'views/new-country.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                        }
                        break;
                }
                break;
        }
    } else if (count($route_parts) == 7) {

    }
}

include_once $chosen_route;
<?php
session_start();

$url_components = parse_url($_SERVER['REQUEST_URI']);

$route = $url_components['path'];

$route_parts = explode('/', $route);
$route_parts = array_filter($route_parts);
$route_parts = array_slice($route_parts, 0);

$chosen_route = 'app/modules/system/view/404.php';

if ($route_parts[0] == 'pytyvo') {
    if (count($route_parts) == 1) {
        $chosen_route = 'app/modules/system/controller/home.php';
    } else if (count($route_parts) == 2) {
        switch ($route_parts[1]) {
            case 'signin':
                $chosen_route = 'app/modules/signin/controller/signin.php';
                break;
            case 'signout':
                $chosen_route = 'app/core/signout.php';
                break;
            case 'signup':
                $chosen_route = 'app/modules/signup/controller/signup.php';
                break;
            case 'administration':
                $chosen_route = 'app/modules/system/controller/administration.php';
                break;
        }
    } else if (count($route_parts) == 3) {
        switch ($route_parts[1]) {
            case 'successful-signup':
                $name = $route_parts[2];
                $chosen_route = 'app/modules/signup/controller/successful-signup.php';
                break;
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        $chosen_route = 'app/modules/system/controller/setup.php';
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
                                $chosen_route = 'app/modules/system/controller/general.php';
                                break;
                            case 'inventory':
                                $chosen_route = 'app/modules/system/controller/inventory.php';
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
                                    case 'country-manager':
                                        $chosen_route = 'views/country-manager.php';
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'brand-manager':
                                        $chosen_route = 'app/modules/brand/controller/manager.php';
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
                                    case 'country-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'views/country.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/brand/controller/maintain.php';
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
        switch ($route_parts[1]) {
            case 'administration':
                switch ($route_parts[2]) {
                    case 'setup':
                        switch ($route_parts[3]) {
                            case 'general':
                                switch ($route_parts[4]) {
                                    case 'country-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'views/country-manager.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/brand/controller/manager.php';
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
    } else if (count($route_parts) == 8) {

    }
}

include_once $chosen_route;
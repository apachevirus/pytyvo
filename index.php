<?php
session_start();

$url_components = parse_url($_SERVER['REQUEST_URI']);

$route = $url_components['path'];

$route_parts = explode('/', $route);
$route_parts = array_filter($route_parts);
$route_parts = array_slice($route_parts, 0);

$chosen_route = 'app/modules/system/controller/404.php';

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
            case 'ajax':
                switch ($route_parts[2]) {
                    case 'machine-get-all-active':
                        $chosen_route = 'app/modules/ajax/machine_get_all_active.php';
                        break;
                    case 'wo-brand-get-all-active':
                        $chosen_route = 'app/modules/ajax/wo_brand_get_all_active.php';
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
                            case 'service':
                                $chosen_route = 'app/modules/system/controller/service.php';
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
                                        $chosen_route = 'app/modules/country/controller/manager.php';
                                        break;
                                    case 'depar-manager':
                                        $chosen_route = 'app/modules/depar/controller/manager.php';
                                        break;
                                    case 'city-manager':
                                        $chosen_route = 'app/modules/city/controller/manager.php';
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'family-manager':
                                        $chosen_route = 'app/modules/family/controller/manager.php';
                                        break;
                                    case 'category-manager':
                                        $chosen_route = 'app/modules/category/controller/manager.php';
                                        break;
                                    case 'subcategory-manager':
                                        $chosen_route = 'app/modules/subcategory/controller/manager.php';
                                        break;
                                    case 'brand-manager':
                                        $chosen_route = 'app/modules/brand/controller/manager.php';
                                        break;
                                    case 'measurement-unit-manager':
                                        $chosen_route = 'app/modules/measurement_unit/controller/manager.php';
                                        break;
                                }
                                break;
                            case 'service':
                                switch ($route_parts[4]) {
                                    case 'machine-manager':
                                        $chosen_route = 'app/modules/machine/controller/manager.php';
                                        break;
                                    case 'wo-brand-manager':
                                        $chosen_route = 'app/modules/wo_brand/controller/manager.php';
                                        break;
                                    case 'model-manager':
                                        $chosen_route = 'app/modules/model/controller/manager.php';
                                        break;
                                    case 'wo-status-manager':
                                        $chosen_route = 'app/modules/wo_status/controller/manager.php';
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
                                                $chosen_route = 'app/modules/country/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'depar-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/depar/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'city-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/city/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'family-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/family/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'category-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/category/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'subcategory-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/subcategory/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/brand/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'measurement-unit-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/measurement_unit/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'service':
                                switch ($route_parts[4]) {
                                    case 'machine-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/machine/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'wo-brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/wo_brand/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'model-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/model/controller/maintain.php';
                                                break;
                                        }
                                        break;
                                    case 'wo-status-manager':
                                        switch ($route_parts[5]) {
                                            case 'maintain':
                                                $chosen_route = 'app/modules/wo_status/controller/maintain.php';
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
                                                $chosen_route = 'app/modules/country/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'depar-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/depar/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'city-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/city/controller/manager.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'inventory':
                                switch ($route_parts[4]) {
                                    case 'family-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/family/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'category-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/category/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'subcategory-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/subcategory/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/brand/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'measurement-unit-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/measurement_unit/controller/manager.php';
                                                break;
                                        }
                                        break;
                                }
                                break;
                            case 'service':
                                switch ($route_parts[4]) {
                                    case 'machine-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/machine/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'wo-brand-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/wo_brand/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'model-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/model/controller/manager.php';
                                                break;
                                        }
                                        break;
                                    case 'wo-status-manager':
                                        switch ($route_parts[5]) {
                                            case 'page':
                                                $page = (int) $route_parts[6];
                                                $chosen_route = 'app/modules/wo_status/controller/manager.php';
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
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
|	$route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples:	my-controller/index	-> my_controller/index
|		my-controller/my-method	-> my_controller/my_method
*/
$route['default_controller'] = 'welcome';
$route['404_override'] = 'errors';
$route['translate_uri_dashes'] = FALSE;

// login
$route['login'] = 'www/login';
$route['login/callback'] = 'www/login/callback';
$route['logout'] = 'www/logout';
// entry
$route['entry'] = 'www/entry/get/0/0/0';
$route['entry/(before|after)/([0-9]+)'] = 'www/entry/get/0/$1/$2';
$route['entry/([a-zA-Z0-9_]+)'] = 'www/entry/get/$1/0/0';
$route['entry/([a-zA-Z0-9_]+)/(before|after)/([0-9]+)'] = 'www/entry/get/$1/$2/$3';
// thread
$route['t/(:num)'] = 'www/thread/get/$1/0/0';
$route['t/(:num)/(before|after)/([0-9]+)'] = 'www/thread/get/$1/$2/$3';
// user
$route['u/([a-zA-Z0-9_]{1,15})/(before|after)/([0-9]+)'] = 'www/user/get/$1/0/$2/$3';
$route['u/([a-zA-Z0-9_]{1,15})'] = 'www/user/get/$1/0/0/0';
$route['u/([a-zA-Z0-9_]{1,15})/(thread|bookmark)/(before|after)/([0-9]+)'] = 'www/user/get/$1/$2/$3/$4';
$route['u/([a-zA-Z0-9_]{1,15})/(thread|bookmark)'] = 'www/user/get/$1/$2/0/0';
// report
$route['report/(thread|res)/([0-9]+)'] = 'www/$1_report/get/$2/0/0';
$route['report/(thread|res)/([0-9]+)/(before|after)/([0-9]+)'] = 'www/$1_report/get/$2/$3/$4';
// tag
$route['tag/(.+)'] = 'www/tag/get/$1/0/0';
$route['tag/(.+)/(before|after)/([0-9]+)'] = 'www/tag/get/$1/$2/$3';
// prv
$route['prv/ng/([a-zA-Z]+)'] = 'www/prv/ng/$1';
// post
$route['post/thread'] = 'www/post/thread';
//----------------------------------------------------------------------
// Admin
//----------------------------------------------------------------------
// user
$route['admin/u/([a-zA-Z0-9_]{1,15})/(report_res|report_thread)/(before|after)/([0-9]+)'] = 'admin/user/get/$1/$2/$3/$4';
$route['admin/u/([a-zA-Z0-9_]{1,15})/(report_res|report_thread)'] = 'admin/user/get/$1/$2/0/0';

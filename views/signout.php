<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
include_once 'app/Redirection.inc.php';

SessionControl::close_session();
Redirection::redirect(SERVER);
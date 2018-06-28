<?php
if (($request == 'new' || $request == 'edit') && isset($validator)) {    // new or edit.
    include_once 'validated.inc.php';
} elseif ($request == 'new' && !isset($model) && !isset($validator)) {    // new.
    include_once 'new.inc.php';
} elseif ($request == 'edit' && isset($model) && !isset($validator)) {    // edit.
    include_once 'edit.inc.php';
} elseif (($request == 'view' || $request == 'delete') && isset($model) && !isset($validator)) {    // view or delete.
    include_once 'delete.inc.php';
}
?>
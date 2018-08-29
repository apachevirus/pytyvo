<?php
function variable_initiated($variable) {
    if (isset($variable) && !empty($variable)) {
        return true;
    } else {
        return false;
    }
}

function get_request() {
    $request = '';

    if (isset($_POST['new'])) {
        $request = 'new';
    } elseif (isset($_POST['view'])) {
        $request = 'view';
    } elseif (isset($_POST['edit'])) {
        $request = 'edit';
    } elseif (isset($_POST['delete'])) {
        $request = 'delete';
    } elseif (isset($_POST['requested_action'])) {
        $request = $_POST['requested_action'];
    }

    return $request;
}

function get_title($request, $repository) {
    $title = '';

    if (isset($request) && isset($repository)) {
        switch ($request) {
            case 'new':
                $title = 'Nuevo';
                break;
            case 'view':
                $title = 'Ver';
                break;
            case 'edit':
                $title = 'Editar';
                break;
            case 'delete':
                $title = 'Eliminar';
                break;
        }

        $title = $title . ' ' . $repository;
    }

    return $title;
}

function get_submit_button_text($request) {
    $text = '';

    if (variable_initiated($request)) {
        switch ($request) {
            case 'new':
                $text = 'Guardar';
                break;
            case 'edit':
                $text = 'Actualizar';
                break;
            case 'delete':
                $text = 'Eliminar';
                break;
        }
    }

    return $text;
}

function get_cancel_button_text($request) {
    $text = '';

    if (variable_initiated($request)) {
        if ($request == 'view') {
            $text = 'Cerrar';
        } else {
            $text = 'Cancelar';
        }
    }

    return $text;
}

function get_cancel_button_title($request) {
    $text = '';

     if (variable_initiated($request)) {
        switch ($request) {
            case 'new':
            case 'edit':
                $text = 'Cancelar los cambios y cerrar formulario';
                break;
            case 'delete':
            case 'view':
                $text = 'Cerrar formulario';
                break;
        }
    }

    return $text;
}

function get_submit_button_class($request) {
    $text = '';

     if (variable_initiated($request)) {
        switch ($request) {
            case 'new':
                $text = 'btn btn-primary btn-md';
                break;
            case 'edit':
                $text = 'btn btn-success btn-md';
                break;
            case 'delete':
                $text = 'btn btn-danger btn-md';
                break;
        }
    }

    return $text;
}

function get_submit_button_title($request) {
    $text = '';

     if (variable_initiated($request)) {
        switch ($request) {
            case 'new':
                $text = 'Guardar los cambios y cerrar formulario';
                break;
            case 'edit':
                $text = 'Actualizar los cambios y cerrar formulario';
                break;
            case 'delete':
                $text = 'Eliminar registro y cerrar formulario';
                break;
        }
    }

    return $text;
}

function get_pagination($page, $total, $url) {
    $html =  '<nav aria-label="Page navigation"><ul class="pagination justify-content-end">';

    if ($total > 5) {
        $html .=  '<li class="page-item"><a class="page-link" href="#">Inicio</a></li>';
    }

    for ($i = 1; $i <= $total; $i++) {
        if ($i !== $page) {
            $html .=  '<li class="page-item"><a class="page-link" href="' . $url . $i . '">' . $i . '</a></li>';
        } else {
            $html .=  '<li class="page-item active"><a class="page-link" href="#">' . $i . '<span class="sr-only">(current)</span></a></li>';
        }
    }

    if ($total > 5) {
        $html .=  '<li class="page-item"><a class="page-link" href="#">Fin</a></li>';
    }

    $html .=  '</ul></nav>';

    return $html;
}
?>
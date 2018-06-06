<?php
include_once 'app/config.inc.php';
include_once 'app/SessionControl.inc.php';
?>

<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <a class="navbar-brand" href="<?php echo SERVER; ?>">
        <i class="icofont icofont-help-robot"></i> Pytyv&#245;
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <?php
                if (isset($_SESSION['company_name']) && !empty($_SESSION['company_name'])) {
                    ?>
                    <a class="nav-link" href="#" data-toggle="tooltip" data-placement="bottom" title="<?php echo 'Empresa: ' . $_SESSION['company_name']; ?>">
                        <i class="fas fa-building"></i>
                        <?php
                        $company_name = mb_convert_case($_SESSION['company_name'], MB_CASE_TITLE, 'UTF-8');
                        $company_name = str_ireplace('s.r.l', 'S.R.L', $company_name);
                        $company_name = str_ireplace('s.a', 'S.A', $company_name);
                        echo '&nbsp;' . $company_name;
                        ?>
                    </a>
                    <?php
                } else {
                    ?>
                    <a class="nav-link" href="#">
                    </a>
                    <?php
                }
                ?>
            </li>
        </ul>
        <ul class="navbar-nav navbar-right">
            <?php
            if (SessionControl::session_started()) {
                ?>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="tooltip" data-placement="bottom" title="<?php echo 'Usuario: ' . $_SESSION['user_name']; ?>">
                        <i class="fas fa-user"></i>
                        <?php
                        if (strpos($_SESSION['user_name'], ' ')) {
                            echo '&nbsp;' . mb_convert_case(substr($_SESSION['user_name'], 0, strpos($_SESSION['user_name'], ' ')), MB_CASE_TITLE, 'UTF-8');
                        } else {
                            echo '&nbsp;' . mb_convert_case($_SESSION['user_name'], MB_CASE_TITLE, 'UTF-8');
                        }
                        ?>
                    </a>
                </li>
                <?php
            }
            ?>
            <li class="nav-item">
                <a class="nav-link" href="<?php echo ROUTE_SIGNOUT; ?>">
                    <i class="fas fa-sign-out-alt"></i> Cerrar sesi&#243;n                    
                </a>
            </li>
        </ul>
    </div>
</nav>
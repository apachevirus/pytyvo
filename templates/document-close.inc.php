        <?php
        if (class_exists('Connection'))
            Connection::disconnect();
        ?>

        <script src="<?php echo ROUTE_JS ?>jquery.min.js"></script>
        <script src="<?php echo ROUTE_JS ?>bootstrap.min.js"></script>
    </body>
</html>
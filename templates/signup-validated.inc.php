<div class="form-group">
    <div class="row">
        <div class="col-md-6">
            <label for="inputUserName" class="label">Nombre de usuario</label>
            <input type="text" maxlength="25" name="username" id="inputUserName" class="form-control" placeholder="" <?php $validator->show_username(); ?> required autofocus>
            <?php $validator->show_error_username(); ?>
        </div>
        <div class="col-md-6">
            <label for="inputName" class="label">Nombre y Apellido</label>
            <input type="text" maxlength="25" name="name" id="inputName" class="form-control" placeholder="" <?php $validator->show_name(); ?> required>
            <?php $validator->show_error_name(); ?>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-12">
            <label for="inputEmail" class="label">Correo electr&#243;nico</label>
            <input type="email" maxlength="100" name="email" id="inputEmail" class="form-control" placeholder="" <?php $validator->show_email(); ?> required>
            <?php $validator->show_error_email(); ?>
        </div>
    </div>
</div>
<div class="form-group">
    <div class="row">
        <div class="col-md-6">
            <label for="inputPassword1" class="label">Contrase&#241;a</label>
            <input type="password" maxlength="25" name="password1" id="inputPassword1" class="form-control" placeholder="" required>
            <?php $validator->show_error_password1(); ?>
        </div>
        <div class="col-md-6">
            <label for="inputPassword2" class="label">Confirmar contrase&#241;a</label>
            <input type="password" maxlength="25" name="password2" id="inputPassword2" class="form-control" placeholder="" required>
            <?php $validator->show_error_password2(); ?>
        </div>
    </div>
</div>
<button type="submit" class="btn btn-success btn-lg btn-block" name="submit">Registrarte</button>
<?php
if (($request == 'new' || $request == 'edit') && isset($validator)) {    // new or edit.
    ?>
    <input type="hidden" name="id" <?php $validator->show_id(); ?>>
    <?php
    if (!empty($validator->show_error_company_id()) || !empty($validator->show_error_id())) {
        ?>
        <div class="form-group">
            <?php $validator->show_error_company_id(); ?>
            <?php $validator->show_error_id(); ?>
        </div>
        <?php
    }
    ?>
    <div class="form-group">
        <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" <?php $validator->show_name(); ?> required autofocus>
        <?php $validator->show_error_name(); ?>
    </div>
    <div class="form-group">
        <label for="inputAreaCode">Prefijo telef&#243;nico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" <?php $validator->show_area_code(); ?> required>
        <?php $validator->show_error_area_code(); ?>
    </div>
    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="checkActive" name="active" <?php $validator->show_active(); ?>>
        <label class="form-check-label" for="checkActive">Vigente</label>
    </div>
    <div class="form-group">
        <?php $validator->show_error_active(); ?>
    </div>
    <?php
} elseif ($request == 'new' && !isset($model) && !isset($validator)) {    // new.
    ?>
    <input type="hidden" name="id" value="0">
    <div class="form-group">
        <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" required autofocus>
    </div>
    <div class="form-group">
        <label for="inputAreaCode">Prefijo telef&#243;nico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" required>
    </div>
    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="checkActive" name="active" checked>
        <label class="form-check-label" for="checkActive">Vigente</label>
    </div>
    <?php
} elseif ($request == 'edit' && isset($model) && !isset($validator)) {    // edit.
    ?>
    <input type="hidden" name="id" value="<?php echo $model->get_id(); ?>">
    <div class="form-group">
        <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" value="<?php echo $model->get_name(); ?>" required autofocus>
    </div>
    <div class="form-group">
        <label for="inputAreaCode">Prefijo telef&#243;nico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" value="<?php echo $model->get_area_code(); ?>" required>
    </div>
    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="checkActive" name="active" <?php if ($model->is_active()) echo 'checked'; ?>>
        <label class="form-check-label" for="checkActive">Vigente</label>
    </div>
    <?php
} elseif (($request == 'view' || $request == 'delete') && isset($model) && !isset($validator)) {    // view or delete.
    ?>
    <input type="hidden" name="id" value="<?php echo $model->get_id(); ?>">
    <div class="form-group">
        <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" value="<?php echo $model->get_name(); ?>" readonly>
    </div>
    <div class="form-group">
        <label for="inputAreaCode">Prefijo telef&#243;nico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
        <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" value="<?php echo $model->get_area_code(); ?>" readonly>
    </div>
    <div class="form-check mb-3">
        <input type="checkbox" class="form-check-input" id="checkActive" name="active" <?php if ($model->is_active()) echo 'checked'; ?> onclick="return false;" disabled readonly>
        <label class="form-check-label" for="checkActive">Vigente</label>
    </div>
    <?php
}
?>
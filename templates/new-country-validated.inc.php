<input type="hidden" name="id" <?php $validator->show_id(); ?>>
<div class="form-group">
    <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
    <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" <?php $validator->show_name(); ?> required autofocus>
    <?php $validator->show_error_name(); ?>
</div>
<div class="form-group">
    <label for="inputAreaCode">Prefijo telefónico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
    <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" <?php $validator->show_area_code(); ?> required>
    <?php $validator->show_error_area_code(); ?>
</div>
<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" id="checkActive" name="active" checked>
    <label class="form-check-label" for="checkActive">Vigente</label>
    <?php $validator->show_error_active(); ?>
</div>
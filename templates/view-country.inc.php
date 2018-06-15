<input type="hidden" name="id" value="<?php echo $country->get_id(); ?>">
<div class="form-group">
    <label for="inputName">Nombre<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
    <input type="text" class="form-control" id="inputName" name="name" maxlength="50" style="text-transform: uppercase;" placeholder="" value="<?php echo $country->get_name(); ?>" readonly>
</div>
<div class="form-group">
    <label for="inputAreaCode">Prefijo telefónico<span class="align-middle" style="color: red; font-size: 0.5rem;"><i class="fas fa-asterisk"></i></span></label>
    <input type="number" class="form-control" id="inputAreaCode" name="area_code" min="1" max="999" placeholder="" value="<?php echo $country->get_area_code(); ?>" readonly>
</div>
<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" id="checkActive" name="active" <?php if ($country->is_active()) echo 'checked'; ?> disabled readonly>
    <label class="form-check-label" for="checkActive">Vigente</label>
</div>
var pytyvoConfig = {
    'baseUrl': 'http://localhost/pytyvo'
};

$(document).ready(function() {
    const REQUESTED_ACTION = $('input[name="requested_action"').length ? $('input[name="requested_action"').val() : null;
    console.log(REQUESTED_ACTION);

    // if ($('#selectMachine').length) {
    //     if (REQUESTED_ACTION === 'new') {
    //         loadMachineMenuOptions();
    //     } else {
    //         $.when(loadMachineMenuOptions()).then(function() {
    //             $('#selectMachine').val($('input[name="curr_machine_id"').val());
    //             console.log($('input[name="curr_machine_id"').val());
    //         });
    //     }
    // }

    // if ($('#selectWOBrand').length) {
    //     if (REQUESTED_ACTION === 'new') {
    //         loadWOBrandMenuOptions();
    //     } else {
    //         $.when(loadWOBrandMenuOptions()).then(function() {
    //             $('#selectWOBrand').val($('input[name="curr_brand_id"').val());
    //             console.log($('input[name="curr_brand_id"').val());
    //         });
    //     }
    // }

    $('#selectDepar').change(function() {
        loadCityMenuOptions();
    });

});

function loadCityMenuOptions() {
    let url = pytyvoConfig.baseUrl + '/ajax/city-get-all-active-filtered-by-depar';
    let depar_id = $('#selectDepar').val();

    $.getJSON(url, {'depar_id': depar_id})
    .done(function(data) {
        $('#selectCity').empty().append('<option value="0">Selecciona una ciudad</option>');
        $.each(data.results, function(i, result) {
            $('#selectCity').append('<option value="' + result.id + '">' + result.name + '</option>');
        })
    })
    .fail(function(jqxhr, textStatus, error) {
        let err = textStatus + ', ' + error;
        console.log('Request failed: ' + err);
    });
}

function loadMachineMenuOptions() {
    let url = pytyvoConfig.baseUrl + '/ajax/machine-get-all-active';

    $.getJSON(url)
    .done(function(data) {
        $('#selectMachine').empty().append('<option value="0">Selecciona una m&#225;quina</option>');
        $.each(data.results, function(i, result) {
            $('#selectMachine').append('<option value="' + result.id + '">' + result.name + '</option>');
        })
    })
    .fail(function() {
        console.log('Request failed: ' + url);
    });
}

function loadWOBrandMenuOptions() {
    let url = pytyvoConfig.baseUrl + '/ajax/wo-brand-get-all-active';

    $.getJSON(url)
    .done(function(data) {
        $('#selectWOBrand').empty().append('<option value="0">Selecciona una marca</option>');
        $.each(data.results, function(i, result) {
            $('#selectWOBrand').append('<option value="' + result.id + '">' + result.name + '</option>');
        })
    })
    .fail(function() {
        console.log('Request failed: ' + url);
    });
}
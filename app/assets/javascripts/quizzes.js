$(function(){

  $('form').on('click','.remove_fields', function(event){

    console.log('Entered remove fields.');

    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();

    event.preventDefault();

  });

  $('form').on('click','.add_fields', function(event){

    console.log('Entered add fields.');

    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));

    event.preventDefault();

  });

  $('.destroy-button-one').on('click', function(event){

    id = $(this).data('id');
    resource = $(this).data('resource');
    $('.destroy-button-two').attr('href', "/"+resource+"/"+id);

  });

  $('.alert-button').on('click', function(event){

    body = $(this).data('body');
    $('#alert-body').html(body);

  });

});


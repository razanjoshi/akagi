$ ->
  $('#case_logo').change ->
    $('#logo_preview').attr 'src', $('#case_logo').val()

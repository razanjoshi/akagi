$ ->

  $('#case_parent_id').change ->

    $.ajax
      type:"POST",
      url:'/cpanel/cases/get_options',
      data:{ id: $(this).val() }
      success: (data) ->
        ops = []
        for s in data
          ops.push "<option value=#{s[0]}>#{s[1]}</option>"
        $('#case_parent_id').html(ops);

    false

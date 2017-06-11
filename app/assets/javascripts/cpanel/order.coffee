$ ->

  $("#appoints_export").click ->
    ids = []
    $("input[name='select_order_check']:checkbox:checked").each ->
      ids.push($(this).val())

    $("#select_ids").val ids

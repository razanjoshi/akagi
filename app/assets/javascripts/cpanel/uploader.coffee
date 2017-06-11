$ ->

  $('#file').change ->

    data = new FormData()
    data.append 'mod', 'product'
    data.append 'photo', $('#file')[0].files[0]

    $.ajax
      url: '/cpanel/photos'
      type: 'POST',
      data: data,
      processData: false,
      contentType: false,
      success: (data) ->
        if data.success == true
          img = data.file_path
          $('#preview').attr 'src',img
          $('input[name="product[logo]"]').val img
          $('input[name="slide[image]"]').val img
          $('input[name="area[photo]"]').val img

    return


  $photos = 0
  $('#product_photo').change ->

    data = new FormData()
    data.append 'mod', 'product'
    data.append 'photo', $('#product_photo')[0].files[0]

    $.ajax
      url: '/cpanel/photos'
      type: 'POST',
      data: data,
      processData: false,
      contentType: false,
      success: (data) ->
        if data.success == true
          img = data.file_path
          div = document.createElement('div')
          div.className = 'uploaded'
          input = document.createElement('input')
          input.name = 'product[photos_attributes][' + $photos + '][image]'
          input.value = img
          input.type = 'hidden'
          div.append input
          divimg = document.createElement('img')
          divimg.src = img
          div.append divimg
          $('#photos').append div
          $photos = $photos + 1


    return
  return

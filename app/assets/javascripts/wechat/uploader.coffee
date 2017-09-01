$ ->
  $photos = 0
  $('#case-file').change ->

    data = new FormData()
    data.append 'photo', $('#case-file')[0].files[0]
    $('p.weui-toast-content').html '上传中'
    $('.wechat-notice').show()

    $.ajax
      url: '/wechat/photos'
      type: 'POST',
      data: data,
      processData: false,
      contentType: false,
      success: (data) ->
        if data.success == true
          img = data.file_path

          html = '<li class="weui-uploader__file" style="background-image:url(' + img + ')"></li>'
          $('.img-preview').append html

          input = document.createElement('input')
          input.name = 'case[photos_attributes][' + $photos + '][image]'
          input.value = img
          input.type = 'hidden'
          $('.img-preview').append input
          $photos = $photos + 1
        else
          wechat_notice('上传失败，请重试')
      error:  ->
        wechat_notice('上传失败，请重试')

    return

  $('#post-file').change ->

    data = new FormData()
    data.append 'photo', $('#post-file')[0].files[0]
    $('p.weui-toast-content').html '上传中'
    $('.wechat-notice').show()

    $.ajax
      url: '/wechat/photos'
      type: 'POST',
      data: data,
      processData: false,
      contentType: false,
      success: (data) ->
        if data.success == true
          $('.wechat-notice').hide()
          img = data.file_path

          html = '<li class="weui-uploader__file" style="background-image:url(' + img + ')"></li>'
          $('.img-preview').append html

          input = document.createElement('input')
          input.name = 'post[photos_attributes][' + $photos + '][image]'
          input.value = img
          input.type = 'hidden'
          $('.img-preview').append input
          $photos = $photos + 1
        else
          wechat_notice('上传失败，请重试')
      error:  ->
        wechat_notice('上传失败，请重试')

    return

  wechat_notice = (notice)->
    $('p.weui-toast-content').html notice
    $('.wechat-notice').show()
    setTimeout  ->
      $('.wechat-notice').hide()
    , 3000

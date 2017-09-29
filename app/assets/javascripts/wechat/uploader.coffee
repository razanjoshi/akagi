$ ->
  $photos = 0

  convertBase64UrlToBlob = (urlData) ->
    bytes = window.atob(urlData.split(',')[1])
    #去掉url的头，并转换为byte
    #处理异常,将ascii码小于0的转换为大于0
    ab = new ArrayBuffer(bytes.length)
    ia = new Uint8Array(ab)
    i = 0
    while i < bytes.length
      ia[i] = bytes.charCodeAt(i)
      i++
    new Blob([ ab ], type: 'image/png')


  $('#image').change ->
    new html5ImgCompress($('#image')[0].files[0],
      done: (file, base64) ->
        index = $photos
        url = '/wechat/photos'
        formData = new FormData
        formData.append 'photo', convertBase64UrlToBlob(base64)
        img = document.createElement('img')
        img.src = base64
        img.className = 'img-responsive'
        li = document.createElement('li')
        li.className = 'weui-uploader__file weui-uploader__file_status'
        li.innerHTML = '<div class="weui-uploader__file-content"><i class="weui-loading"></i></div>'
        li.append img
        li.setAttribute 'id', 'image' + index
        $('.img-preview').append li
        $.ajax(
          url: url
          type: 'POST'
          cache: false
          data: formData
          processData: false
          contentType: false).done((data) ->
          photo = data.file_path
          $('#image' + index).removeClass 'weui-uploader__file_status'
          $('#image' + index + ' img').attr 'src', photo
          input = document.createElement('input')
          input.name = 'case[photos_attributes][' + $photos + '][image]'
          input.value = photo
          input.type = 'hidden'
          $('.img-preview').append input
          $photos = $photos + 1
          return
        ).fail (res) ->
        return
      notSupport: (file) ->
        alert '浏览器不支持！'
        # 不支持操作，例如PC在这里可以采用swfupload上传
        return
  )
    return



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

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

        img = $('<img src="" class="img-responsive">')
        img.attr('src', base64)
        li = $('<li class="weui-uploader__file weui-uploader__file_status"><div class="weui-uploader__file-content"><i class="weui-loading"></i></div></li>')
        li.append img
        li.attr 'id', 'image' + index
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

  $('#qiniuimage').change ->
    fileName = $('#qiniuimage').val().split('\\').pop()
    f = $('#qiniuimage')[0].files[0]
    data = new FormData()
    data.append 'filename', fileName
    $.ajax
      url: '/wechat/photos/gettoken'
      type: 'POST',
      data: data,
      processData: false,
      contentType: false,
      success: (data) ->
        token = data.token
        key = data.key
        photo = data.photo
        new html5ImgCompress(f,
          done: (file, base64) ->
            index = $photos
            url = '/wechat/photos'
            li = $('<li class="weui-uploader__file weui-uploader__file_status" style="background-image:url(' + base64 + ')"><div class="weui-uploader__file-content"><i class="weui-loading"></i></div></li>')
            li.attr 'id', 'image' + index
            $('.img-preview').append li

            formData = new FormData
            formData.append 'file', convertBase64UrlToBlob(base64)
            formData.append('token', token);
            formData.append('key',key)
            xhr = new XMLHttpRequest();
            xhr.open('POST', 'http://up.qiniu.com', true);
            xhr.send(formData);
            xhr.onreadystatechange = (response)->
              if (xhr.readyState == 4 && xhr.status == 200 && xhr.responseText != "")
                blkRet = JSON.parse(xhr.responseText);
                showphoto photo
              else if (xhr.status != 200 && xhr.responseText)
                blkRet = JSON.parse(xhr.responseText);
                console.log(blkRet);
        )


  showphoto =(photo)->
    $('#image' + $photos).removeClass 'weui-uploader__file_status'
    $('#image' + $photos).attr 'style', 'background-image:url(' + photo + ')'
    input = document.createElement('input')
    input.name = 'case[photos_attributes][' + $photos + '][image]'
    input.value = photo
    input.type = 'hidden'
    $('.img-preview').append input
    $photos = $photos + 1

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

$ ->

  if $('#product_descrip').length > 0
    new Simditor({
      textarea: $('#product_descrip')
      placeholder: '请输入内容...'
      upload:
        url: '/cpanel/photos'
        fileKey: 'photo'
    })


  $('#photos').delegate 'div.uploaded','click',() ->
  #$('.uploaded').on 'click', ->
    #$('.photo').html("你好")
    if (!confirm('是否删除图片') )
      return
    else
      $(this).remove()

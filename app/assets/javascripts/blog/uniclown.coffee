$ ->
  $body = $('body')

  $('.sidebar-toggle').on 'click', (e) ->
    console.log 'test'
    $body.toggleClass 'sidebar-opened'
    e.preventDefault()
    return

  $('.overlay').on 'click', (e) ->
    $body.removeClass 'sidebar-opened search-opened'
    #searchField.clear()
    e.preventDefault()
    return

  $('.search-toggle').on 'click', (e) ->
    if $body.hasClass('search-opened')
      $body.removeClass 'search-opened'
      #searchField.clear()
    else
      $body.addClass 'search-opened'
      setTimeout (->
        $('#search-field').focus()
        return
      ), 300
    e.preventDefault()
    return

  $prev = $('ul.pagination a').first()
  $next = $('ul.pagination a').last()

  $prev.addClass('newer-posts square dark')
  $prev.html('<span class="icon-left-custom" aria-hidden="true"></span><span class="screen-reader-text">Newer Posts</span>')
  $next.addClass('older-posts square dark')
  $next.html('<span class="screen-reader-text">Older Posts</span><span class="icon-right-custom" aria-hidden="true"></span>')

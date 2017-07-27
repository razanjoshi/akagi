$ ->

  if $(".dropload-content").length > 0
    url = $(".dropload-content").data("url")
    console.log(url)
    console.log("start dropload")
    current_page = 1

    $(".dropload-content").dropload
      scrollArea: window,
      loadDownFn: (me) ->
        current_page++
        $.ajax
          url: url
          type: "GET"
          dataType: "html"
          data: { more: "more", page: current_page }
          success: (returnHtml) ->
            # there is a newline
            if returnHtml.length > 1
              $(".dropload-content .list").append(returnHtml)
              console.log(current_page)

            else
              console.log("no data")
              me.lock()
              me.noData()

            me.resetload()
          error: (xhr, type) ->
            me.resetload()
            me.lock()
            me.noData()

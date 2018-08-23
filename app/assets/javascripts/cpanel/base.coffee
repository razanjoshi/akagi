# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    if $('#editormd').length > 0
        window.Editor = editormd('editormd',
            width   : "100%",
            height  : "800px",
            syncScrolling : true,
            path: "    /editormdlib/")
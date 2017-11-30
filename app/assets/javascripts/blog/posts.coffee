# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  window.Editor = editormd('editormd',
    width   : "80%",
    height  : "800px",
    path: "    /editormdlib/")
  return

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


ready = ->
  $('.book-form').hide()

  $('#show-form').on 'click', (e) ->
    e.preventDefault()
    $('.book-form').toggle()

$ ->
  ready(ready)
  
$ ->
  $("#myTab a:last").tab('show')

$(document).on 'page:load', ready

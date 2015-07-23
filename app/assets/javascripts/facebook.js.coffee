jQuery ->
  $('body').prepend('<div id="fb-root"></div>')

  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/sdk.js"
    dataType: 'script'
    cache: true


window.fbAsyncInit = ->
  FB.init
    appId: '243698082320463'
    cookie: true
    version: 'v2.2'

  $('#sign_in').click (e) ->
    e.preventDefault()
    FB.login (response) ->
      window.location = '/users/auth/facebook/callback' if response.authResponse

  $('#sign_out').click (e) ->
    FB.getLoginStatus (response) ->
      FB.logout() if response.authResponse
    true

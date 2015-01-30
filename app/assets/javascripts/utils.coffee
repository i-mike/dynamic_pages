window.current_localization = ->
  window.location.pathname.split("/")[1]

window.current_page = ->
  /\/pages\/(.+)\//.exec(window.location.pathname)[1]

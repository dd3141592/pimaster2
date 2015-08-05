Template.gamesFoot.rendered = ->
  # get our button so we can add a Famous click handler
  fview = FView.byId 'hb'
  target = fview.surface
  target.on "click",(evt) =>
    # tell our render controller which template to show (the home page)
    Session.set 'currentHeadFootContentTemplate','homeScrollView'
    # tell iron:router to redirect our browser to the home page (builds a new context and all)
    Router.go '/'
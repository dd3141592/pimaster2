Router.route '/', ->
  this.render 'appMainView'

Router.route '/games', ->
  this.render 'gamesScrollView'
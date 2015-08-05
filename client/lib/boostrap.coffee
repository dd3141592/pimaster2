 #declare namespaces
window.App ?= {}
window.Famous ?={}


Meteor.startup  ->
  Logger.setLevel 'famous-views','debug'
  App.events = new Famous.EventHandler
    # create a variable in our App namespace (so coffeescript can get to it)
  # that defines the type of transition we want the rendercontroller to use
  # note: this is a famous-views specific definition for sliding left
  App.transitionContent =  'slideWindow'

  # set the Session variable that will tell the rendercontroller which template
  # to render. All reactive ! We will be rendering ScrollViews as our content
  # this sets the template we want to display when the app is loaded
  Session.set 'currentHeadFootContentTemplate','homeScrollView'
  Session.set 'serverURL', location.origin
  Session.set 'design', 'I will add content'

Meteor.subscribe 'chat'
Meteor.subscribe 'players'
Meteor.subscribe 'cards'
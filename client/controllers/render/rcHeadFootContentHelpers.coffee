Template.rcHeadFootContent.helpers
  'showTemplate': ->
    Template[this.name]
  'getTransition': ->
    App.transitionContent
  'currentTemplate': ->
    Session.get 'currentHeadFootContentTemplate'

# remember - a function return value is implied with coffeescript
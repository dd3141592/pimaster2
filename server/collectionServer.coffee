Chat.allow
    insert: (userId, doc) ->
      return true
    update: (userId, doc, fields, modifier) ->
      return false
    remove: (userId, doc) ->
      return false

Meteor.publish 'chat', ->
    Chat.find()


Cards.allow
    insert: (userId, doc) ->
      return true
    update: (userId, doc, fields, modifier) ->
      return true
    remove: (userId, doc) ->
      return false   

Players.allow
    insert: (userId, doc) ->
      return false
    update: (userId, doc, fields, modifier) ->
      return true
    remove: (userId, doc) ->
      return false 

             
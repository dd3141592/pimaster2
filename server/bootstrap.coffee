Meteor.startup  ->

  initPlayers()
  initCards()
  shuffle()
  Meteor.call('deal',10,1);
  Meteor.call('deal',10,2);
  Meteor.call('deal',10,3);
  Meteor.call('deal',10,4);

   

# our server side method that the client will call to delete records from Chat
Meteor.methods
  removeChat: (id) ->
    Chat.remove _id: id,    # _id is a mongo generated unique record id
      (error,res) =>     # callback that gets called when function completes
        if error
          throw new Meteor.Error(404, error.sanitizedError)
          return error
        else
          return ''

   
         
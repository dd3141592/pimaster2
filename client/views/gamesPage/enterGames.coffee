Template.enterGames.events
 
# ios bug.... button is getting dbl clicks even with fastclick fix
# this is a meteor click event hook on our 'add' button
  'click #ebtn': (evt,tmpl) ->
    # a little meteor trick here to find a DOM element in a template (our text field)
    # meteor is nice enough to send us the template that contains our button
    d = tmpl.find("#tfield").value
    if App.ebtn is false
      # perform a direct insert into the collection
      Chat.insert
        text: d
      , (error,res) ->    #completion callback
          if error
            # we just got a validation error from Simple Schema (collection2)
            alert error
      # yes we can also do jQuery
      $("#tfield").val("")
      App.ebtn = true
    Meteor.setTimeout ->
      App.ebtn = false
    ,500
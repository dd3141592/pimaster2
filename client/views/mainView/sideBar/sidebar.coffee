Template.sidebar.rendered = ->

  flag = off
  #loop through our 5 menu items and add click event processing code
  for i in [1..5]
    fview = FView.byId("m"+i)
    target = fview.surface
    target.on "click",(evt) =>
      if  flag is off   #double click iOS bug protection
        flag = on
        #this is where we cheat and get the item name from our class list 'sidebar m[1-4] templatename'
        #refer to the code above to see the class parameters again. Famous inserts a class entry at 
        #the beginning and end of our list. That's why we are getting the third element (classList[2])
        #of the array. Remember arrays start indexing at 0.

        s = FView.byId(evt.currentTarget.classList[2])

        # we animate the menu item by moving it to the left 50 pixels and when that has completed
        # we move it back to it's original position via a completion callback
        s.modifier.setTransform Famous.Transform.translate(-50,0),{duration: 500},=>
          s.modifier.setTransform Famous.Transform.translate(0,0),{duration: 500}

        if evt.currentTarget.classList[3] isnt 't_sidebar_inline'
          c = evt.currentTarget.classList[3]
          App.events.emit 'swipeleft',c          

        Meteor.setTimeout ->
          flag = off
        ,500

  timerFired = (nm) ->
    s = FView.byId("m" + nm)
    s.modifier.setTransform Famous.Transform.translate(0,0,-1),{duration: 200}

  App.events.on 'animate',=>
    for i in [1..5]
      x = FView.byId("m" + i)
      x.modifier.setTransform  Famous.Transform.translate(0,(6-i)*100,-1) 
    for nm in [1..5] 
      delay = nm*200
      Famous.Timer.setTimeout(timerFired.bind(this,nm),delay)


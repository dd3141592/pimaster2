Template.appMainView.rendered = ->

  flag = off #double click protection
  slideDuration = 300 #how fast we want the animation to be - in milliseconds

  #get our header and footer surfaces
  hdrS = FView.byId('hamburger').surface
  ftrS = FView.byId('footerS').surface

  labelS = FView.byId('label').surface
  noticeS = FView.byId('notice').surface
#create a transitionable so we can animate our header/footer view
  hfl = new Famous.Transitionable 0 #initialize to 0

#get the header/footer layout view so we can attach a transformFrom to it's modifier
#we gave it an id of 'hfl' above when we created it. 
  fview = FView.byId 'hfl'

# animate the header-footer-layout view using a transitionable value
# remember that our transformFrom callback function will be running at 60FPS!
# The transitionable will be used to move the view from the far left (original position)
# to the right for a distance of 70% of the current window width.
#
# Remember the Transform.translate X and Y coordinates are relative to the 'original' position of 
# the renderable. Not absolute screen coordinates. 
# So 0,0 is the original position at creation time.
# A minus X value would move it to the left (even off the screen). Positive X values move it to
# right. And a value of zero returns it to its original position. 
  fview.modifier.transformFrom =>
    currentPosition = hfl.get()
    return Famous.Transform.translate(currentPosition,0, 0)

# monitor mouse and touch events in the X direction only
# A sync is basically just a filter. We tell it what type of events we want to respond to
# The GenericSync is a way to listen to multiple event sources such as mouse and touch
# Famo.us can respond to a lot of touch events, such as pinching, multi-finger, swiping, dragging
# So we want to create a sync that responds to mouse (for PC), and touch (mobile,tablet,etc) 
# and we are only interested in changes in the X direction (left and right). We can use our new
# sync object to notify us of 'start','end', and 'update' events (to name a few).

  sync = new Famous.GenericSync ['mouse','touch'],
       {direction: Famous.GenericSync.DIRECTION_X}

# Capture events   - the use of PIPES
# We have to get our events from somewhere and this is where piping comes into play
# for testing we are going to capture all events on our window by using the 
# Famous.Engine which watches EVERYTHING going on. So the next line tells the Engine to send
# (pipe) all events to our GenericSync (sync)
# The real app (after testing) will only pipe events from selected Surfaces. 
#add the next three lines just under the slideDuration= line at the top
#pay attention to the indenting !


  #pipe our header and footer surfaces to our GenericSync
  hdrS.pipe sync
  ftrS.pipe sync

# this is just checking for a mouse up or drag/touch ending
# we are not doing real time sliding via 'update' callback
# wish someone would fix the iOS double click crap
# Remember variable 'hfl' is our transistionable.

  sync.on 'end', =>
    if flag is off              #no click pending - ok to proceed
      flag = on                 #prevent processing of rapid double clicks bug on iOS
      #check to see if panel is all the way to the left 
      if hfl.get() is 0     
        #move panel to 70% of screen width to the right - animate it 
        #(this is a pixel offset from align) no easing!
        hfl.set window.innerWidth - (window.innerWidth*.30),{duration: slideDuration}
        #move the backing surface 'back' under the sidebar menu 
        #so the menu can be visible (chg z index)
        FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-10)
        App.events.emit 'animate'

      else
        #animate back to the left (0 offset from original position)
        hfl.set 0,{duration: slideDuration},=>
          #bring the backing over the sidebar to hide it - 
          #could have just 'hid' the sidebar with CSS
          #this is a callback executed after transition
          FView.byId('backing').modifier.setTransform Famous.Transform.translate(0, 0,-2)
      #clear click flag after 200 milliseconds so we can process more real clicks
      Meteor.setTimeout ->   
        flag = off
      ,200

  App.events.on 'swipeleft', (page) =>
    if page is 'games'
      Router.go '/games'
      return
    # the sidebar is sending us the template name (page) in the event
    # the page variable will be one of 'design', 'games', 'home', or 'dribble'
    # update our header text fields
    labelS.setContent page.charAt(0).toUpperCase() + page.slice(1)
    if page is 'home'
      noticeS.setContent 'Welcome!'
    else
      noticeS.setContent 'Enjoy'
      
    # animate our header/footer view (hfl) back to the left (it's origin)
    # take 500 milliseconds and when finished (via callback)
    # tell the render controller to load our new template
    if page isnt 'design'
      # go ahead and slide panel left and load new page
      hfl.set 0,{duration: 500},=>
        Session.set 'currentHeadFootContentTemplate',page+'ScrollView'
    else
    # setting an array of query parameters we want added to our URL
    # in this case it will add ?token=iamgood and we will check for it on the
    # server side to provide a cheap means of access control
      sp =
        params:
          "token":'iamgood'
 
  # the information we are requesting - we will be getting back a JSON string
  # of the data (text of post/article whatever)
      url = Session.get('serverURL')+'/rest/design/'
 
  # perform the request to the server then render
      HTTP.call 'GET',url,sp,(error,result) =>
        if error
          t = 'Please check your internet connection'
        else
          t = JSON.parse(result.content).text
        Session.set 'design',t
        hfl.set 0,{duration: 500},=>
          Session.set 'currentHeadFootContentTemplate','designScrollView'     
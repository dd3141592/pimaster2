# i.e. mysite.com/rest/design?token=iamgood
 
# just in case someone forgets to request an article
Router.route '/rest', ->
  this.response.statusCode = 401
  this.response.end 'ERROR'
,
  where: 'server'   # this is significant - tells iron router server side only
 
# article is our placeholder for the article name
Router.route '/rest/:article', ->
 
  # get the info we need out of the request URL
  t = this.params.article
  token = this.params.query.token
 
  # if a token query value was specified - make sure it's valid
  # in real life - we would return 401 if token not there
  if token?
    if token isnt 'iamgood'
      this.response.statusCode = 401
      this.response.end 'ERROR'
      return
 
  this.response.statusCode = 200
  this.response.setHeader "Content-Type", "application/json"
  # allow cross origin
  this.response.setHeader "Access-Control-Allow-Origin", "*"
  this.response.setHeader "Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept"
  if t is 'design'
    # the only article name we respond to
    this.response.end JSON.stringify     # return it as JSON using a key of 'text'
      text: DesignText
 
  else
    this.response.statusCode = 401
    this.response.end 'ERROR'
,
  where: 'server'
 
# sample data to send back - simple HTML
 
DesignText = '<div class="task container">
<h1>Design and Technology</h1>
 
 
<p>Lorem ipsum ultricies risus sit tempor mattis turpis, scelerisque vitae aliquet egestas inceptos semper a, risus turpis molestie porta inceptos justo dictumst volutpat litora gravida eget sit diam morbi curabitur eleifend eget augue adipiscing a.</p>
 
<p>Sit fringilla facilisis himenaeos at vivamus gravida senectus fermentum ad pharetra, venenatis platea pharetra class nullam rutrum posuere egestas dapibus dui magna sapien duis nisi fames erat aenean nulla.</p>
 
<p>Augue placerat fringilla sodales rutrum ultricies bibendum curae, hac tincidunt vehicula scelerisque laoreet curae, dictumst convallis phasellus integer nam facilisis augue etiam pretium aenean eros aliquet cras lobortis tortor aliquet.</p>
 
<p>Cubilia feugiat imperdiet scelerisque sed eleifend per eleifend, quisque elementum leo at donec phasellus, nullam non ullamcorper class tortor tempus.</p>
 
<p>Tincidunt litora habitasse euismod iaculis sagittis rutrum nam est lacus, torquent pharetra mi sed et aliquam cras aenean, sed nec fringilla amet fermentum est mauris commodo.</p>
 
</div>'
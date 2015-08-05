Template.gamesScrollView.helpers({
  	'items': function(){
  				query = Cards.find({'playerId' : 1});
				console.log('query count : ' + query.count());
			 	return 	query;
			 },

  	'peanuts': function(){
				query = Chat.find({});
				return query;
			},
	'peanut': function(){
				query = Cards.find({});
				return query;
			}
});



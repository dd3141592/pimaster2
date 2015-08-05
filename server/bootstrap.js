 Meteor.methods({

   "deal" :  function(numCardsPerHand, playerNum){
      console.log('dealing');
      if(shuffleOrder.length <1){
        shuffle();
      }

      var hand = [];
      console.log('playerNum: ' + playerNum);
      console.log('numCardsPerHand: ' + numCardsPerHand);
      for(var k = 0; k< numCardsPerHand; k++)
      {
        var j = (playerNum - 1)*numCardsPerHand + k;
        var next = getCardFromShuffledDeck(j);
        console.log('hand next: ' + next);
        hand.push(next);
      
      }
      var error = '';
      Cards.update({ index: { $in: hand } } , {$set: {playerId: playerNum}}, { multi: true },
        function(err){
          if(err){
            console.log('err in updating cards:' + err);
            error = err;
          } else {
            console.log('finished updating cards:');
            
          }

        });
        return error;    

     //console.log('num Cards in playerId hand: ' + Cards.find({'playerId': playerNum}).count());   
     
     
    
    // else{
    //   console.log('deal on the client');
    //   // result.cards = Cards.find({'playerId' : "0"});
    //   return result;
    // }
  }
});

numCardsPerHand = 10;

shuffleOrder =[];

shuffle = function(){
  
shuffleOrder = [];
for(var i = 0; i <Cards.find().count(); i++)
{
  shuffleOrder.push({Index: i, Value: Math.random()});
}
  shuffleOrder.sort(function(a,b){
    return a.Value - b.Value;
  });
console.log("shuffled");
};


getCardFromShuffledDeck = function(i){
  
    return shuffleOrder[i].Index;
};


initPlayers= function(){
  if (Players.find().count() === 0) {
    var names = ["Ada Lovelace",
                 "Grace Hopper",
                 "Marie Curie",
                 "Carl Friedrich Gauss"];
    for (var i = 0; i < names.length; i++)
      Players.insert({name: names[i],playerNum: i+1, score:0});

  }  
  Meteor.publish("players", function(){
    //console.log('published players count: ' + Players.find().count());
    return Players.find();
  });  
};


initCards=function(){
 
 Cards.remove({});
  // if(Cards.find().count() === 0) {  
    var cardValues = [
    '1/2', '1/3', '1/4','1/5','1/6','1/7','1/8','1/9','1/10','1/11', '1/12',
    '1/4','1/9','1/16','1/25','1/36','1/49','1/64','1/81','1/100','1/121','1/144',
    '2','3','4','5','6', '7', '8','9','10','11','12',
    '4','9','16','25','36','49','64','81','100','121','144',
     '1','1','1','1','1','1','1','1'    
];  
/*    var faceValue2 = [
    '1/2', '1/3', '1/4','1/5','1/6','1/7','1/8','1/9','1/10','1/11', '1/12',
    '1/4','1/9','1/16','1/25','1/36','1/49','1/64','1/81','1/100','1/121','1/144',
    '2','3','4','5','6', '7', '8','9','10','11','12',
    '4','9','16','25','36','49','64','81','100','121','144',
     '1','1','1','1','1','1','1','1','1','1','1','1',
    '1/8','1/27','1/64','1/125','1/218','1/342','1/512','1/729','1/1000',             '1/1331', '1/172',
    '8','27','64','125','218','342','512','729','1000','1331', '1728'  
];*/
 for(var  j= 0; j<cardValues.length; j++){
  Cards.insert({index:j, Value:cardValues[j] , playerId: 0}); 
  //Cards.insert({text: cardValues[j]});  
}
// }
  
Meteor.publish("cards", function(){ 
  //console.log('published cards count: ' + Cards.find().count());
  return Cards.find();  
  });  
  
};






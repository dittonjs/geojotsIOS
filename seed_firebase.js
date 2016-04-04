var Firebase = require("firebase")

var roomsRef = new Firebase("https://geojots.firebaseio.com/rooms");
var jotsRef = new Firebase("https://geojots.firebaseio.com/jots/1");
roomsRef.set([
  {
    title: "Atomic Jolt Hack Day",
    description: "This is a really cool hack day",
    members: 12,
    id: 1
  } 
], function(error){
  if(error) console.log(error);
  else console.log("seeded room");
});

jotsRef.set([
  {
    user_name: "dittonjs",
    user_id: 1,
    date: (new Date()).toString(),
    content: "This is pretty awesome"
  }
], function(error){
  if(error) console.log(error);
  else console.log("seeded jots");
})


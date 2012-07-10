var databaseUrl = "mydb"; // "username:password@example.com/mydb"
var collections = ["users","reports"]
var db = require("mongojs").connect(databaseUrl,collections);



db.users.save({email: "rurabe@gmail.com", password: "pword", sex: "male"}, function(err, saved){
	if(err || !saved) console.log("User not saved");
	else console.log("User saved");
});

db.users.find({sex: "male"}, function(err, users) {
  if( err || !users) console.log("No female users found");
  else users.forEach( function(maleUser) {
    console.log(maleUser);
  } );
});

db.users.update({email: "rurabe@gmail.com"}, {$set: {password: "iReallyLoveMongo"}}, function(err, updated) {
  if( err || !updated ) console.log("User not updated");
  else console.log("User updated");
});

db.users.find({sex: "male"}, function(err, users) {
  if( err || !users) console.log("No female users found");
  else users.forEach( function(maleUser) {
    console.log(maleUser);
  } );
});

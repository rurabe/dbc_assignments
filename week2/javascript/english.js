var english = {};
var americanEnglish = Object.create(english);
var britishEnglish = Object.create(english);

var define = function(dictionary,word,definition){
	dictionary[word] = definition;
};

define(english,"house","place to live");
define(english,"tree","big green thing");
define(english,"street","where cars drive");
define(americanEnglish,"elevator","car to ride up and down");
define(americanEnglish,"truck","big car");
define(britishEnglish,"lift","car to ride up and down");
define(britishEnglish,"lorrie","big car");


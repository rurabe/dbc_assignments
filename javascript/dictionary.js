
var english = {
	entries: {},
	add: function(word,definition) {
		english.entries[word] = definition;
	},
	doesInclude: function(word) {
		return word in english.entries
	},
	find: function(substring){
		var results = [];
		for(var key in english.entries){
			if(english.entries[key].indexOf(substring) === 0){
				results.push(english.entries[key]);
				return results;
			}
		}	
	},
	listAll: function(){
		keys(english.entries).sort().forEach(function(e){
			console.log(e, english.entries[e]);
		});
	}
};	

english.add("duck","bird")
english.add("ship","on the sea")
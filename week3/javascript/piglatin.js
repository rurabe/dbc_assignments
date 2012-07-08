var pigLatin = function(word){
	var vowels = /[aeiou]/;
	var firstVowel = word.search(vowels);
	if (word.substr(0,2) === "qu"){
		return word.substr(2,word.length) + "quay";
	}
	if (firstVowel === 0){
		return word + "ay";
	}
	else if (firstVowel > 0)
		return word.substr(firstVowel,word.length) + word.substr(0,firstVowel) + "ay";
};
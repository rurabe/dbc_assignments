var titleCase = function(title){
	var words = title.split(" ");
	i=0
	while(i<words.length){
		var first = words[i].split("")[0].toUpperCase();
		words[i] = first + words[i].substr(1,words[i].length)
		i++;
	}
	return words.join(" ")
};
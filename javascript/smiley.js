var smiley = function(object){
	if (object["mood"] === "happy"){
		return ":)";
	}
	else if (object["mood"] === "sad"){
		return ":(";
	}
	else{
		return ":|";
	}
}
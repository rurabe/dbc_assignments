var secretDataStore = function(mode,key,value) {
	store = store || {};
	if(mode === "set") {
		store[key] = value;
	}
	else if (mode === "get"){
		return store[key];
	}
	else {
		console.log("no function: " + mode)
	}
};
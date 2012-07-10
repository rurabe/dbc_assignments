var stack = function() {
	var stack = {
		data: [],
		size: function(){
			return this.data.length;
		},
	
		add: function(arg){
			this.data.push(arg)
		}
	};

	return stack;
	
};

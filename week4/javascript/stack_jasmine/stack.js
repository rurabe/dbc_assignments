var obj = {}
var stackMaker = function() {
	var stack = {
		data: [],
		size: function(){
			return stack.data.length;
		},
	
		add: function(arg){
			this.data.push(arg)
		}
	};

	return stack;
	
};


var stack = stackMaker();

stack.size();
var stack = {
		data: [],
		size: function(){
			return this.data.length;
		},
	
		add: function(arg){
			this.data.push(arg)
		},
		
		remove: function(){
			if (this.size() === 0){
				throw new Error("Stack is already empty!")
			}else{
				return this.data.pop();				
			}
		}
};

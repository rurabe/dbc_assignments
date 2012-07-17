// Assignment: test drive the creation of a stack object
// 
// stack should be an object
// stack should have a size
// stack.size should be 0
// stack should have an add method
// stack.add(item) should increase size by 1
// stack.add(item), stack.add(item) should increase size by 2
// after adding several items to a stack, stack.remove() should reduce size by 1
// after stack.add(item), stack.remove() should return item
// without adding any items to a stack, stack.remove() should throw an error
// keep thinking of tests and building out your stack implementation
// Assignment: test drive the creation of a stack class
// 
// the constructing function should return a stack-like object. convert your above tests to operate on the result of this constructor
// the constructing function should accept a list of values and initialize the stack to include them

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

var stackMaker = function(){

	return stack;
};
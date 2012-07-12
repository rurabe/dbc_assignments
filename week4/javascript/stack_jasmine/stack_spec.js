describe("The stack", function() {
	
	beforeEach(function() {
	    stack.data = []
	  });

  it("should be an object", function() {
    expect(stack).toEqual(jasmine.any(Object));
  });


	it("should have a size", function(){
		expect(stack.size()).toEqual(0);
	});
	
	it("should have an add method", function(){
		stack.add('item');
		expect(stack.size()).toEqual(1);
	});
	
	it("should increment by 1 with an existing stack", function(){
		expect(stack.size()).toEqual(0);
		stack.add('item1');
		stack.add('item2');
		stack.add('item3');
		stack.add('item4');
		expect(stack.size()).toEqual(4);
		stack.add('item5');
		expect(stack.size()).toEqual(5);
	});
	
	it("should have a remove method", function(){
		stack.add('item');
		expect(stack.size()).toEqual(1);
		stack.remove();
		expect(stack.size()).toEqual(0);
	});
	
	it("should return the most recently added item from the remove function", function(){
		stack.add('item');
		expect(stack.size()).toEqual(1);
		expect(stack.remove()).toEqual('item');
	});
	
	it("should raise an error if you try to remove from an empty stack", function(){
		expect(stack.remove()).toThrow(new Error("Stack is already empty!"));
	});
	
});
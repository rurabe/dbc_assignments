describe("The stack", function() {

  it("should be an object", function() {
    expect(stack).toEqual(jasmine.any(Object));
  });


	it("should have a size", function(){
		expect(stack.size).toEqual(0)
	})
	
	it("should have an add method", function(){
		stack.add('item')
		expect(stack.size).toEqual(1)
	})
});
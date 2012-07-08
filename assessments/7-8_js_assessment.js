// Ryan Urabe
// Assessment
// 7/8/2012

// Exercise 1

	var newConcat = function(string1,string2){
		return string1 + string2;
	};

// Exercise 2

	var sum = function(array){
		var aggregate = 0;
		for (i=0;i<array.length;i++){
			aggregate = aggregate + array[i];
		}
		return aggregate;
	};

// Exercise 3

	// index 3 is "nice". "javascript" is index 0. the length of the array is 8.

// Exercise 4

	var funString = function(string){
		var charArray = string.split('');
		var newArray = [];
		for (var i=0;i<charArray.length;i++){
			if(i%2 === 0){
				newArray.push(charArray[i]);
			}
			else if(i%2 === 1){
				newArray.push(charArray[i].toUpperCase());
			}
		}
		return newArray.reverse().join();
	};
	
// Exercise 5

	var fizzBlam = function(){
		for (var i=1;i<101;i++){
			if(i % 35 === 0){
				console.log("FizzBlam");
			}else if(i % 7 === 0){
				console.log("Blam");
			}else if(i % 5 === 0){
				console.log("Fizz");
			}else {
				console.log(i);
			}
		}
	};
	
// Exercise 6

	var guessingGame = function(answerInit){
		var gameObject = {
			answer : answerInit,
			guess : function(currentGuess){
				if (currentGuess > this.answer){
					console.log("high");
				}else if (currentGuess < this.answer){
					console.log("low");
				}else if (currentGuess === this.answer){
					console.log("correct");
					this.solved = true;
				}
			},
			solved : false
		}
		return gameObject;
	};
	
// Exercise 7

	// The first is assigning a new variable to 'value', whereas the second is changing
	// a property of some object's key myVariable to 'value'. You would use the first
	// basically anytime you declare a new variable. You would use the second where
	// you have an object and want to store 'value' under the myVariable key within
	// that object. Specifically, the object in question also contains the code that
	// references this, much like ruby objects which can refer to self.
	
// Exercise 8
	
	// 1
	// This function will take each element, multiply it by 100 and print it to 
	// the console.
	
	// 2
	// This function evaluates each element and makes all values greater than the
	// first value equal to the first value. It then returns the modified array.
	
	// 3
	// This function returns a new array where each element has been increased by 80.
	
	// 4
	// This function returns an array with only the even index numbers (which are 
	// actually the odd numbered elements in the array).
	
// Exercise 9

	fruits().peaches; //  Returns 7
	fruits().peaches(); // 	Error, beacuse peaches is not a function, its a key in a obj
	fruits().apples; // undefined, apples is not part of the obj returned from fruits
	oranges; // Error, oranges has only been defined inside that func and is not avail outside
	fruits().crate(); // Returns 10
	
//Exercise 10

	console.log(animals.dog); // 'woof' because dog is a valid key of obj animals
	console.log(animals.stepOnTail); // meowZERS!! because animals can see cat, and adds ZERS
	console.log(animals.cat); // undefined, no key cat for animals
	console.log(animals.duck); //text of the function assigned to duck, because it was not invoked
	console.log(animals.duck()); // quack, because it just got invoked
	
//Exercise 11

	//It's the same as the difference between puts and return in ruby. console.log prints
	// to the console, return makes the value available to other functions as a result of 
	// running that function.
	
//Exercise 12

	// The first is recursive so it has to run twice for each one, increasing exponentially
	// the second only runs once per fibonacci number.
	
//Last question

	// Oh it took around 3 or 4 hours from start to finish, but I had dinner with Marcus
	// and was doing other things in the meantime. I'm guessing total working time was around
	// 1.5 or 2 hours.
	
	
	
	
	
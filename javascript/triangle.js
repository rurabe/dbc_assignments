var triangle = function(side1,side2,side3){
	var sides = [side1,side2,side3].sort(function(a,b){return a-b});
	if ((sides[0] + sides[1]) <= sides[2]){
		return "invalid";
	}
	else if (side1 === side2 && side2 === side3){
		return "equilateral";
	}
	else if (side1 === side2 || side2 === side3){
		return "isoceles";
	}
	else {
		return "scalene";	
	}
};
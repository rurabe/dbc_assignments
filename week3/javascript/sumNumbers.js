var sumNumbers = function(numbers){
	var size = numbers.length;
	i = 0;
	var sum = 0;
	while (i<size){
		sum = sum + numbers[i];
		i++;
	}
	return sum
};
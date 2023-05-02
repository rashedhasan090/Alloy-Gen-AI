/* Fixed code */
pred inv4 {
	all x : Init, y : State | y in x.^trans
} 
/* Note: switched the order of x and y in the subset expression */
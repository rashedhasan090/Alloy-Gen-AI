
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | Teaches.c in Teacher 
}

Note that the "Class in Teacher.Teaches" part has been replaced with "Teaches.c in Teacher".
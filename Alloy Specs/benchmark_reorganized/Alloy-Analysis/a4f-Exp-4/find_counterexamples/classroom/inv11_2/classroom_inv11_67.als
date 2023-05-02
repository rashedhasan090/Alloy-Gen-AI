
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c: Class | (some Groups.c) implies some Teaches.c 
}
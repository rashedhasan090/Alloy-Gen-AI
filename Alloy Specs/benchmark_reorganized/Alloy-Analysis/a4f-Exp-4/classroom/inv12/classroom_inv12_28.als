/* The bug was in inv12, where the quantifier used to check if a teacher has classes with groups assigned to them was incorrect. The corrected code is provided below. */
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t : Teacher, c : Class | t->c in Teaches implies some g : Group | c->t->g in Groups  
}
The bug was in the inv11 predicate, where the implication was the wrong way around. The repaired code for inv11 is as follows:

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,g:Group | some p:Person | c->p->g in Groups implies p in c.Teacher 
}

Note that the "p in Teacher" condition was changed to "p in c.Teacher" to correctly refer to the teachers assigned to a specific class.
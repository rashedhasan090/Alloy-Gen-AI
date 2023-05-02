
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,s:Student,g:Group | c->s->g in Groups implies some t:Teacher | c->t->g in Groups   
}

should be:

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some c.Groups) implies some Teacher & Teaches.c 
}
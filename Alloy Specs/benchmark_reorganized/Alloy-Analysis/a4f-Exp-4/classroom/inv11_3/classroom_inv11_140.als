
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class, p:Person, g:Group | p->c not in Teaches implies c->p->g not in Groups 
}
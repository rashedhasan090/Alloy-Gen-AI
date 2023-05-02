
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
	all c:Class, g:Group | some t:Teacher | c->t->g in Groups implies c->g in Groups
}
The bug in inv11 is that the implication should be from the existence of groups to the existence of a teacher and teaches relation for that class, not the other way around. The repaired code is:

/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,g:Group | some p:Person | c->p->g in Groups implies p in Teacher & p.Teaches = c 
}
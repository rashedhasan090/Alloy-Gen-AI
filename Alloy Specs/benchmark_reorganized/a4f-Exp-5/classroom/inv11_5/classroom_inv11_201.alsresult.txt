/* Fixed inv11: A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,s:Student | some g:Group | c->s->g in Groups implies some t:Teacher | c->t->g in t.Teaches.Groups 
}
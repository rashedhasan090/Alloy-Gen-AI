
/* Each teacher is responsible for some groups. */
pred inv12 {
	all t:Teacher | some g:Group,c:Class | t->c->g in Groups 
}
pred inv12_OK {
	all t:Teacher | some c:Class | (some p:Person, g:Group | c->p->g in Groups and p=t) implies t->c in Teaches
}
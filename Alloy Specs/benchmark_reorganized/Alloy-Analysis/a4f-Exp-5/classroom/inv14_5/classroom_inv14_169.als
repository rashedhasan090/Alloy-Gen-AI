pred inv14_OK {
  all c:Class, s:Student, g:Group | some t:Teacher | (t->c in Teaches) and (c->s->g in Groups implies g in t.Groups) 
}
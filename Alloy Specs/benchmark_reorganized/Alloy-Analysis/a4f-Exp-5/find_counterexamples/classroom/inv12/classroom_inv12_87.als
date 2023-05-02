pred inv12_OK {
 all c:Class | some t:Teacher,g:Group | c->t->g in Groups implies t in Teaches.c 
}
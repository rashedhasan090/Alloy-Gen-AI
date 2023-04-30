pred inv12_OK {
 all t : Teacher, g : Group , c : Class | t->c->g in Groups implies t in Teaches.c 
}
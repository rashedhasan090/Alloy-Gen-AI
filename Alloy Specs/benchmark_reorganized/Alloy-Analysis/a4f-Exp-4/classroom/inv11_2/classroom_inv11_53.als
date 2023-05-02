
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
 
 all c : Class, g : Group | some t : Teacher, p : Person | c->p->g in Groups implies t->c in Teaches and p = t 
}
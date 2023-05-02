
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
    all c : Class | some s : Student | some g : Group | c->s->g in Groups implies (some t : Teacher | t->c in Teaches) 
}
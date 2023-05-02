
/* A class only has groups if it has teachers assigned. */
pred inv11 {
    all c:Class, g:Group | some t:Teacher | (c->t->g in Groups) iff g in c.Groups
}
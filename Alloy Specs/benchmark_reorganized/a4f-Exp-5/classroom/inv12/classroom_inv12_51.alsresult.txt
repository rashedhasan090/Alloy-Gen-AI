pred inv12_OK {
 all t : Teacher , g : Group, c : Class | t->c in Teaches and c->s->g in Groups implies g in (t.Teaches).Groups
}
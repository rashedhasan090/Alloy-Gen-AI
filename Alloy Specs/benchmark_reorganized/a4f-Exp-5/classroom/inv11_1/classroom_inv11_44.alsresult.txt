pred inv11_OK {
  all c : Class | (some c.Teaches) implies some t : Teacher | some s : Student | some g : Group | c->s->g in Groups and t->c in Teaches
}
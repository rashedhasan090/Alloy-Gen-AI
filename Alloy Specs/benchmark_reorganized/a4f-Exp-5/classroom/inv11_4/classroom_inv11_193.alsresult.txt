pred inv11_OK {
  all c : Class, g: Group | (some t:Teacher | c->t->g in Groups) implies some t:Teacher | t->c in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
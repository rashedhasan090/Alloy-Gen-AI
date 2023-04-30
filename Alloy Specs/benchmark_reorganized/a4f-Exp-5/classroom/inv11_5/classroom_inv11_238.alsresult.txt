pred inv11_OK {
  all c : Class | (some p : Person | some g : Group | c->p->g in Groups) implies some t : Teacher | t->c in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
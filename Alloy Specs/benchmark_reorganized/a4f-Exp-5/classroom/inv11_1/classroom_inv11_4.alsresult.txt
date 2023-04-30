/*Fixed code*/
pred inv11_OK {
  all c : Class | (some g : Group | c->Person->g in Groups) implies some t :Teacher |  c->t in Teaches  
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
pred inv11_OK {
  all c : Class, g: Group | some s: Student, t: Teacher | c->s->g in Groups implies t->c in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
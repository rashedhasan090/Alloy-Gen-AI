pred inv11_OK {
  all c : Class | some t:Teacher,g:Group | some c.Groups.g implies c->t->g in Groups and t->c in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
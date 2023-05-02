pred inv10_OK {
  all x, y : File | x->y in link implies y in Trash 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
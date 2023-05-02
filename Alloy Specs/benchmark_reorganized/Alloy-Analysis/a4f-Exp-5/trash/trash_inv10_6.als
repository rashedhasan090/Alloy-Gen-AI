// Fixed inv10 predicate
pred inv10_OK {
  all f,g:File | (f->g in link and f in Trash) implies g in Trash 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
check inv10_Repaired expect 0
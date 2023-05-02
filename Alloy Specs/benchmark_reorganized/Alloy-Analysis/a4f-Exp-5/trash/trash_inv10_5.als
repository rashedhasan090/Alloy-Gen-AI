pred inv10_OK {
  all f,g:File | f->g in Trash.link implies f in Trash
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
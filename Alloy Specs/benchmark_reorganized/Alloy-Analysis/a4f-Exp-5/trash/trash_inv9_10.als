/* A link does not link to another link. */
pred inv9_OK {
  all f:File | lone f.link
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
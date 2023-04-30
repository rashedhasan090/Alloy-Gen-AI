//Fixed inv6
pred inv6_OK {
  all f: File | lone f.link implies f->one f.link
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
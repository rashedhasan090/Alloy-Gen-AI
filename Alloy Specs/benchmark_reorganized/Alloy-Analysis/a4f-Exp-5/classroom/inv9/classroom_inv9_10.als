pred inv9_OK {
  all c:Class | lone t:Teacher | t -> c in Teaches implies (some g:Group | c->g in t.Teaches.Groups)
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
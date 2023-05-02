pred inv10_OK {
  	link.Trash in Trash 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
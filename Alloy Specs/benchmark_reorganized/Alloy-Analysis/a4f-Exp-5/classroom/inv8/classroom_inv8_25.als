pred inv8_OK {
  all t:Teacher | lone c:Class | t->c in Teaches 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
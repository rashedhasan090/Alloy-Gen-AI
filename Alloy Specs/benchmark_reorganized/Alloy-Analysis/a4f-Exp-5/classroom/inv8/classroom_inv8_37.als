pred inv8_OK {
  all c:Class | lone Teaches[c] & Teacher 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
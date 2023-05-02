pred inv8_OK {
  all c:Class | lone Teacher & Teaches.c 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
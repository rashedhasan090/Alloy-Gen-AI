pred inv9_OK {
  all c:Class | lone Teacher & c.Teaches 
}

assert inv9_Repaired {
  inv9[] iff inv9_OK[]
}
pred inv11_OK {
  all c : Class | (some c.Teaches) implies some Teacher & Teaches.c 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
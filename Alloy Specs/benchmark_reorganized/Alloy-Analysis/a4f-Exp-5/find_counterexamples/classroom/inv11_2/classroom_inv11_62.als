pred inv11_OK {
  all c : Class | (some c.Teaches) implies some t : Teacher | (c -> t) in Teaches 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
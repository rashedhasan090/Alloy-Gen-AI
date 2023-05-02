
pred inv11_OK {
  all c : Class | (some c.Groups) implies some t:Teacher & t.Teaches = c 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
pred inv11_OK_fixed {
  all c : Class | (some c.Groups) implies some p:Teacher | c in p.Teaches
}
assert inv11_Repaired_fixed {
    inv11[] iff inv11_OK_fixed[]
}
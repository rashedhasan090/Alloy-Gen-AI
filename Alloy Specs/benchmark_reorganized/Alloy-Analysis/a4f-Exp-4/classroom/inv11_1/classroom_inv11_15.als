
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
  all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
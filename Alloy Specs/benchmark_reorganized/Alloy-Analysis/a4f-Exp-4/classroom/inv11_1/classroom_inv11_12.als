The bug was in inv11 -- the original assertion checked that every class has at most one group assigned, but the repaired assertion checked that every class has a group assigned if it has a teacher assigned. The fixed assertion should check that if a class has groups assigned, then it also has a teacher assigned. Here is the fixed code:

/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
  all c : Class | (no c.Groups) or some Teacher & Teaches.c 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
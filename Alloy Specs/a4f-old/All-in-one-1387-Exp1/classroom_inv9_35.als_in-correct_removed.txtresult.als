pred inv9_OK {
 all c:Class | lone Teaches.c -- correct  (fixed)
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
--------
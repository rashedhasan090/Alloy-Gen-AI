pred inv9_OK {
  all c:Class | lone c.Teaches & Teacher --correct
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
--------
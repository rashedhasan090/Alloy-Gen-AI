
pred inv4_OK {
  all c:Component | c.parts.cposition in c.cposition.*prev
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
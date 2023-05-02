
pred inv4_OK {
  all c:Component | ((c.^parts) & Component).cposition not in (c.cposition).*next
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
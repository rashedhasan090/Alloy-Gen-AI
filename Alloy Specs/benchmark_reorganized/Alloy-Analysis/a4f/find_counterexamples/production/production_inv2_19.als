open util/ordering[Position]
sig Position {}
sig Product {}
sig Component extends Product {
    parts : set Product,
    cposition : one Position
}
sig Resource extends Product {}
sig Robot {
        rposition : one Position
}
pred inv1 {
    all c : Component | some c.parts
}
pred inv2 {
    all c : Component | c not in c.^parts
}
pred inv3 {
    all c : Component | c.cposition in Robot.rposition
}
pred inv4 {
    all c : Component | c.parts.cposition in c.cposition.^prev
}
pred inv2_OK {
    no Component & iden.parts & iden.cposition
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
check inv2_Repaired
pred inv4_OK {
    all c : Component | c.parts.cposition in c.cposition.^prev
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
check inv4_Repaired
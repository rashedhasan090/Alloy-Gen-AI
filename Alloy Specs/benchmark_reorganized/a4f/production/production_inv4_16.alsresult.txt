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

// A component requires at least one part
pred inv1 { 
    all c:Component | some c.parts
}

// A component cannot be a part of itself
pred inv2 { 
    all c:Component | c not in c.^parts
}

// The position where a component is assembled must have at least one robot
pred inv3 { 
    all c:Component | c.cposition in Robot.rposition
}

// The parts required by a component cannot be assembled in a later position
pred inv4 { 
    all c:Component | c.parts.cposition in c.cposition.*next 
}

// Repairing inv4
pred inv4_OK {
    all c:Component | c.parts.cposition in c.cposition.~prev
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

// PerfectOracleCommands
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0

// Repairing inv4
pred repair_pred_1{
    inv4[] iff inv4_OK[]
}

run repair_pred_1

assert repair_assert_1{
    inv4[] iff inv4_OK[]
}

check repair_assert_1
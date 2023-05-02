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
	all c:Component | some c.parts
}

pred inv2 {
	all c : Component | no c.parts & c.cposition
}

pred inv3 {
	Component.cposition in Robot.rposition
}

pred inv4 {
	all c:Component | c.parts.cposition in c.cposition.*prev 
}

pred inv2Fixed {
	all c : Component | no c.(c<:parts) & c.cposition 
}

assert inv2_Repaired {
    inv2[] iff inv2Fixed[]
}

pred inv2_OK {
	all c:Component | c not in c.^parts 
}

assert inv1_Repaired {
    inv1[] iff (all c:Component | some c.parts)
}

assert inv3_Repaired {
	inv3[] iff (Component.cposition in Robot.rposition) 
}

assert inv4_Repaired {
	inv4[] iff (all c:Component | c.parts.cposition in c.cposition.*prev) 
}

check inv1_Repaired
check inv2_Repaired
check inv3_Repaired
check inv4_Repaired
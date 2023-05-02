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
	all c : Component | c.parts !in c
}
pred inv3 {
	Component.cposition in Robot.rposition
}
pred inv4 {
    all c:Component | c.parts.cposition in c.cposition.*prev 
}
pred inv2_fixed {
	all c : Component | c.parts !in c.parts
}
assert no_component_part_of_itself {
    inv2 [] iff inv2_fixed []
}
pred inv1_fully_repaired {
	all c:Component | some c.parts 
}
assert inv1_repaired {
    inv1 [] iff inv1_fully_repaired []
}
pred inv3_fully_repaired {
	Component.cposition in Robot.rposition 
}
assert inv3_repaired {
    inv3 [] iff inv3_fully_repaired []
}
pred inv4_fully_repaired {
    all c:Component | c.parts.cposition in c.cposition.*prev 
}
assert inv4_repaired {
    inv4 [] iff inv4_fully_repaired []
}
check no_component_part_of_itself
check inv1_repaired
check inv3_repaired
check inv4_repaired
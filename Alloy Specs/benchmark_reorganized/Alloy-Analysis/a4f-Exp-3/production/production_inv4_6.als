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
	all c:Component | c not in c.^parts
}

pred inv3 {
	all r:Robot | one c:Component | c.cposition=r.rposition
}

pred inv4 {
	all c:Component | no p:Component & p in c.parts & p.cposition>c.cposition
}

pred inv4_OK {
    all c:Component | c.parts.cposition in c.cposition.*prev  
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

run inv4_Repaired for 5 but 6 Position, 4 Product, 6 Component, 2 Resource, 2 Robot

pred inv3_OK {
	all r:Robot | one c:Component | c.cposition=r.rposition
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

check inv3_Repaired for 5 but 6 Position, 4 Product, 6 Component, 2 Resource, 2 Robot

pred inv2_OK {
	all c:Component | c not in c.^parts
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

check inv2_Repaired for 5 but 6 Position, 4 Product, 6 Component, 2 Resource, 2 Robot

pred inv1_OK {
	all c:Component | some c.parts
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

check inv1_Repaired for 5 but 6 Position, 4 Product, 6 Component, 2 Resource, 2 Robot
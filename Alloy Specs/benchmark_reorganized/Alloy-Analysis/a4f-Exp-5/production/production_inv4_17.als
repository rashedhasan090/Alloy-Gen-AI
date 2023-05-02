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
	Component.cposition in Robot.rposition
}

pred inv4 {
	all c:Component | c.parts.cposition not in c.cposition.^prev
}

pred inv4_OK {
	all c:Component | c.parts.cposition in c.cposition.*prev  
}

pred repair_pred_1{inv4[] iff inv4_OK[] }

run repair_pred_1

assert repair_assert_1{inv4[] iff inv4_OK[] }

check repair_assert_1

----------------
// Bonus question: Can you explain in a sentence or two what the purpose of ordering[Position] is in this spec?

The ordering[Position] utility module guarantees a total order of the universe of atoms of the sig Position, which means that we can use the `.next` and `.prev` operators to traverse the ordered elements of the set in a predictable way.
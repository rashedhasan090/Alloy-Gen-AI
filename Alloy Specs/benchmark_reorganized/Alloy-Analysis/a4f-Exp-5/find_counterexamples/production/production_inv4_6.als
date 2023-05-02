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
	all r:Robot | one rposition
}
pred inv4 {
	all c: Component |
		all p: c.parts |
			(cposition.cnext & p.cposition.prev) = none
}
pred inv5 {
	all c: Component |
		cposition in c.parts.cposition
}
pred inv6 {
	all r:Robot |
		r.rposition in Component.cposition
}
pred inv7 {
	all r:Robot |
		no c: Component |
			(c.cposition.cnext & r.rposition.prev) = none
}
pred inv8 {
	all c: Component |
	{ cposition } = c.parts.cposition
}
pred inv9 {
	all r1, r2: Robot |
		r1 != r2 implies r1.rposition != r2.rposition
}
run {} for 10
check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7
check inv8
check inv9
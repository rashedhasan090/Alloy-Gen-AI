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
	all c:Component | c.cposition in Robot.rposition
}
pred inv4 { 
	all c:Component | c.parts.cposition in c.cposition.*prev
}
pred inv_OK {
    inv1[] and inv2[] and inv3[] and inv4[]
}
assert repaired_inv {
    inv_OK
}
check repaired_inv for 4  but 4 Component, 3 Position, 2 Product, 1 Robot, 0 Resource
run {}
```
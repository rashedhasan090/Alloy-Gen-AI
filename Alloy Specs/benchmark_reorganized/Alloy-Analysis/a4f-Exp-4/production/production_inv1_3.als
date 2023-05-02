Fixed code:

open util/ordering[Position]

sig Position {}

sig Product {}

sig Component extends Product {
    parts: set Product,
    cposition: one Position
}

sig Resource extends Product {}

sig Robot {
    rposition: one Position
}

pred inv1 {
    all c: Component | some c.parts
}

pred inv2 {
    all c: Component | c not in c.^parts
}

pred inv3 {
    all c: Component | c.cposition in Robot.rposition
}

pred inv4 {
    all c: Component | c.parts.cposition in c.cposition.*prev
}

pred invFix {
    inv1[] and inv2[] and inv3[] and inv4[]
}

assert Correctness {
    all r: Robot, c: Component | c.cposition = r.rposition implies c.parts.cposition in r.rposition.*next
}

check invFix
run Correctness for 5
check Correctness for 5
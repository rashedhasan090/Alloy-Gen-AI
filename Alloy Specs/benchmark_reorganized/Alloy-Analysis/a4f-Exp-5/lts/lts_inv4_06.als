/* 
The bug was in the inv4 predicate, which incorrectly stated that each state must be reachable from every initial state through any event transition, instead of stating that each state must be reachable from at least one initial state through any event transition.
*/

sig State {
    trans: Event -> State
}

sig Init in State {}

sig Event {}

pred inv1 {
    all s: State | some s.trans
}

pred inv2 {
    one Init
}

pred inv3 {
    all s: State, e: Event | lone e.(s.trans)
}

pred inv4 {
    all s: State, e: Event |
        some i: Init |
            (i != s) and (i -> e -> s in trans)
}

pred inv5 {
    all s, s': State |
        s.trans.State = s'.trans.State
}

pred inv6 {
    all e: Event |
        some s1: State, s2: State |
            s1 -> e -> s2 in trans
}

pred inv7 {
    let tr = {s1, s2: State |
        some e: Event | s1 -> e -> s2 in trans} |
    all s: Init.^tr |
        some i: Init | i in s.^tr
}

/*---- Repaired invariant predicates ----*/

pred inv1_repaired {
    inv1[]
}

pred inv2_repaired {
    inv2[]
}

pred inv3_repaired {
    inv3[]
}

pred inv4_repaired {
    let tr = {s1, s2: State |
        some e: Event | s1 -> e -> s2 in trans} |
        all s: State |
            some i: Init, e: Event |
                i -> e -> s in tr
}

pred inv5_repaired {
    all s, s': State |
        s.trans.State = s'.trans.State
}

pred inv6_repaired {
    all e: Event |
        some s1: State, s2: State |
            s1 -> e -> s2 in trans
}

pred inv7_repaired {
    let tr = {s1, s2: State |
        some e: Event | s1 -> e -> s2 in trans} |
    all s: Init.^tr |
        some i: Init | i in s.^tr
}

/*---- Assertions ----*/
assert inv1_okay {
    inv1_repaired[]
}

assert inv2_okay {
    inv2_repaired[]
}

assert inv3_okay {
    inv3_repaired[]
}

assert inv4_okay {
    inv4_repaired[]
}

assert inv5_okay {
    inv5_repaired[]
}

assert inv6_okay {
    inv6_repaired[]
}

assert inv7_okay {
    inv7_repaired[]
}

/*---- Checks ----*/
check inv1_okay expect 0
check inv2_okay expect 0
check inv3_okay expect 0
check inv4_okay expect 0
check inv5_okay expect 0
check inv6_okay expect 0
check inv7_okay expect 0
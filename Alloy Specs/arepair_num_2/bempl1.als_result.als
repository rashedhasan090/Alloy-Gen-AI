The bug is in the definition of the abstract sig Person. All people are assigned a set of keys, including employees who are not researchers. To fix this, the set of keys should only be assigned to researchers. 

Fixed specification:

/*
Further simplification of Dan's work
access is granted to all assigned groups.
*/
sig Room {}
one sig secure_lab extends Room {}

/*
Bug:
*/
abstract sig Person {}

sig Employee in Person {}
sig Researcher in Person {
    owns : set Key
}

/*
access
*/
sig Key {
    authorized: one Employee,
    opened_by: one Room
}

pred CanEnter(p: Person, r:Room) {
    r in p.owns.opened_by
}

/*
assertion
*/
assert repair_assert_1 {
    all p : Person | CanEnter[p, secure_lab] implies p in Researcher
}
check repair_assert_1

pred repair_pred_1{
    some opened_by
    some owns
    all p : Person | CanEnter[p, secure_lab] implies p in Researcher
}
run repair_pred_1
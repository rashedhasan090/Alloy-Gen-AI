// Fixed code:

// rooms
sig Room {}
one sig secure_lab extends Room {}

// people
abstract sig Person {
  owns : set Key
}
sig Employee, Researcher extends Person {}

// access
sig Key {
  authorized: one Researcher,
  opened_by: one Room
}

pred CanEnter(p: Person, r: Room) {
  r in p.owns.opened_by
}

// assertion
assert repair_assert_1 {
  all p : Person | CanEnter[p, secure_lab] implies p in Researcher
}

// predicate to check if assertion is satisfied
pred repair_pred_1 {
  all p: Person | CanEnter[p, secure_lab] implies p in Researcher
}

check repair_assert_1
run repair_pred_1 for 4 Person, 3 Room, 6 Key  // example instance to test the fixed code
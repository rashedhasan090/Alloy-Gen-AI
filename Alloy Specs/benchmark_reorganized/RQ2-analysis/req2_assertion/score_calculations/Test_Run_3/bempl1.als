// Rooms
sig Room {}
one sig secure_lab extends Room {}

// People
// Fixed: Only researchers can own keys
abstract sig Person {
  owns : set Key
}
sig Employee {}
sig Researcher extends Employee {}

// Access
sig Key {
  authorized: one Employee,
  opened_by: one Room
}

pred CanEnter(p: Person, r: Room) {
  r in p.owns.opened_by
}

// Assertion
assert repair_assert_1 {
  all p: Person | CanEnter[p, secure_lab] implies p in Researcher
}
check repair_assert_1

// Predicate for testing
pred repair_pred_1 {
  // Fixed: Declare opened_by and owns as non-empty
  some opened_by: Room, owns: set Key |
    some p: Person | CanEnter[p, secure_lab] implies p in Researcher
}
run repair_pred_1
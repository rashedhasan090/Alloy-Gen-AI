//Rooms
sig Room {}
one sig secure_lab extends Room {}

//People
abstract sig Person {
  owns: set Key
}
sig Employee extends Person {}
sig Researcher extends Employee {}

//Access
sig Key {
  authorized: one Employee,
  opened_by: one Room
}
fact {
  all k: Key | k.authorized in Employee
}

pred CanEnter(p: Person, r: Room) {
  r in p.owns.opened_by
}

//Assertion
assert repair_assert_1 {
  all p: Person | CanEnter[p, secure_lab] implies p in Researcher
}

check repair_assert_1

pred repair_pred_1{
  some opened_by
  some owns
  all p: Person | CanEnter[p, secure_lab] implies p in Researcher
}

run repair_pred_1
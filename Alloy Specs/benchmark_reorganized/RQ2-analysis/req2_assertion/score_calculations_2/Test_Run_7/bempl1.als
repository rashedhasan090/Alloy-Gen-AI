//Fixed code:
//rooms
sig Room {}
one sig secure_lab extends Room {}

//people
abstract sig Person {
  owns : set Key
}
sig Employee, Researcher extends Person {}

// access
sig Key {
  authorized: one Employee,
  opened_by: one Room
}

pred CanEnter(p: Person, r:Room) {
  r in p.owns.opened_by
}

// assertion
assert repair_assert_1 {
  all p : Person -- Employee | CanEnter[p, secure_lab]
}
check repair_assert_1

pred repair_pred_1{
  some opened_by
  some owns
  all p : Person -- Employee | CanEnter[p, secure_lab]
}
run repair_pred_1
//Fixed code

//rooms
sig Room {}
one sig secure_lab extends Room {}

//people
abstract sig Person {
  owns : set Key
}
sig Employee extends Person {}
sig Researcher extends Employee {}

// access
sig Key {
  authorized: one Employee,
  opened_by: one Room
}

pred CanEnter(p: Person, r:Room) {
	exists k: p.owns | k.opened_by = r and k.authorized = p
}

// assertion
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
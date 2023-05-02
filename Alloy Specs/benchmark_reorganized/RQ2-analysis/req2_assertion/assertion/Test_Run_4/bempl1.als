// Fixed code
// access is granted to all assigned groups except for the employee who owns the key
// Fix:
// The authorized field of Key should refer to the Researcher sig instead of Employee sig
// The CanEnter predicate needs to check if the authorized employee is different from the owner of the key

// rooms
sig Room {}
one sig secure_lab extends Room {}

// people
abstract sig Person {
  owns : set Key
}
sig Employee extends Person {}
sig Researcher extends Person {}

// access
sig Key {
  authorized: one Researcher,
  opened_by: one Room
}

pred CanEnter(p: Person, r: Room) {
  all k: p.owns | k.opened_by = r and k.authorized != p
}

// assertion
assert repair_assert_1 {
  all p : Person | CanEnter[p, secure_lab] implies p in Researcher
}

check repair_assert_1

pred repair_pred_1 {
  some opened_by, owns
  all p : Person | CanEnter[p, secure_lab] implies p in Researcher
}

run repair_pred_1
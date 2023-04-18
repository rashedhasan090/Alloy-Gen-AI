sig Person {}

sig Car {
  owner : lone Person // Each car can have at most one owner, represented as a lone Person
}

fact {
  no p : Person | no c : Car | c.owner = p // No car can have an owner that doesn't exist
}

run {
  some c : Car | some p : Person | c.owner = p // There must be at least one car and one person
  all c : Car | lone c.owner // Each car can have at most one owner
  no p : Person | no c : Car | c.owner = p // No car can have an owner that doesn't exist
} for 3 but 3 Person, 3 Car // Set the scope of the run command to 3 for both Person and Car sigs.
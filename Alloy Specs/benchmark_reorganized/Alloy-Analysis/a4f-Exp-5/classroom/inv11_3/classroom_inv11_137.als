pred inv11_OK {
  all c : Class | some p:Person | (some c.Groups) implies c->p in Teaches and p in Teacher
}
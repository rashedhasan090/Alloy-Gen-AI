/* Fixed inv11 predicate */
pred inv11_OK {
  all c : Class | (some c.Groups) implies some t: Teacher | t->c in Teaches 
}
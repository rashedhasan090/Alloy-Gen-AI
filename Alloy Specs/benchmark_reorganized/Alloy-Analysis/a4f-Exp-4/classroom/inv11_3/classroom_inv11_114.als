
Fixed inv11 predicate: 

/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
  all c : Class | (some c.Groups) iff some Teacher & Teaches.c 
}
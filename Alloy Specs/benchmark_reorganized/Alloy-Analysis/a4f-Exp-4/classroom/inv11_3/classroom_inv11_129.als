
/* A class only has groups if it has a teacher assigned. */
pred inv11_OK {
  all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}

Here is the fixed code:

/* Every class has at least one teacher assigned. */
pred inv7 {
  all c:Class | some Teacher & Teaches.c 
}
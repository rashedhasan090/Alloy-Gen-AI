
/* No class has more than one teacher assigned. */
pred inv9_OK {
  all c:Class | lone (c.Teaches & Teacher) 
}

/* No class has more than one teacher assigned. */
pred inv9 {
 all c : Class | lone t:Teacher | t in c.Teaches 
}
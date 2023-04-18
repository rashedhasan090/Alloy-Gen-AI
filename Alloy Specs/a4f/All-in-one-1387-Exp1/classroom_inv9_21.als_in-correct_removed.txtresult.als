The bug is in predicate inv9. The correct predicate is given below:

pred inv9 {
  all c:Class | lone c.Teaches & Teacher
}
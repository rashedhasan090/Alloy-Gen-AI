There is a missing reference to the Teaches relation in predicate inv9. The correct predicate is:

pred inv9 {
    all c:Class | lone c.Teaches & Teacher --fixed
}
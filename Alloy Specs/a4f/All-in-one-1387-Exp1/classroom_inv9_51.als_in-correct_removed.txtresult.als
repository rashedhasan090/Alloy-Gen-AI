There is a bug in predicate inv9. The correct code is provided below:

pred inv9 {
    all c:Class | lone (Teaches.c & Teacher)
}
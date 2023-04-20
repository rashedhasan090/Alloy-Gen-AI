The bug is in inv9, the correct formula should be:

/* No class has more than one teacher assigned. */
pred inv9 {
    all c:Class | lone Teachers.c --fixed
}
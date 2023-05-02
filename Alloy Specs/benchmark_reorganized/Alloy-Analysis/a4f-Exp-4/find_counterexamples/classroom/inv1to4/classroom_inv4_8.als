
/* No person is neither a student nor a teacher. */
pred inv4 {
    all p:Person | p in Student or p in Teacher 
}
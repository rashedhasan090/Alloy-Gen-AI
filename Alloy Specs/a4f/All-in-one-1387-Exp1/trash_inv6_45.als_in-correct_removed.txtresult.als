The bug in the specification is in the inv6 predicate. The comment on the line containing the formula is missing the beginning "--" to comment out the previous formula. The fixed code is as follows:

/* A file links to at most one file. */
pred inv6 {
   -- ~link . link in iden -- is commented out
   some x,y : File | x->y in link
}
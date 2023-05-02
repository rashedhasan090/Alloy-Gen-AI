The bug is in the predicate inv6. The correct predicate is:

/* A file links to at most one file. */
pred inv6 {
 all f : File | lone g : f.link
}
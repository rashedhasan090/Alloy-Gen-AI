The bug in this specification is in the inv6 predicate. The correct code for the predicate is as follows:

/* A file links to at most one file. */
pred inv6 {
  all f:File | lone f.link
}
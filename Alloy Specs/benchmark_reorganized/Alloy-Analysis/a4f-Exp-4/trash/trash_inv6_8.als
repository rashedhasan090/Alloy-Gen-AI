The bug: The predicate inv6 is incorrect. 

Fixed code for inv6 (only the predicate is shown):

/* A file links to at most one file. */
pred inv6 {
  all f : File | lone link.f
}
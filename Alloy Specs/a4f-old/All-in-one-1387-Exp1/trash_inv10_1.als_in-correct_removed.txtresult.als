The bug in the specification is in predicate inv10. The correct predicate is:

/* If a link is deleted, so is the file it links to. */
pred inv10 {
  Trash.link in Trash.link.@link
}
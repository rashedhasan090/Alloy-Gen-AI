The bug in the code is in the invariant inv10. The correct code should be:

/* If a link is deleted, so is the file it links to. */
pred inv10 {
  Trash.link -> Trash in Trash --correct
}
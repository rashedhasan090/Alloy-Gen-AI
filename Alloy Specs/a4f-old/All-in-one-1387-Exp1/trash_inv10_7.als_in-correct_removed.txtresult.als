There is a commented out line in the inv10 predicate. The fixed code should be:

/* If a link is deleted, so is the file it links to. */
pred inv10 {
    Trash.link in Trash --correct
}
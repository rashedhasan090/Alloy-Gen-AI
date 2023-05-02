Fix for inv10:

/* If a link is deleted, so is the file it links to. */
pred inv10 {
	all f: Trash.link | f.link in Trash 
}
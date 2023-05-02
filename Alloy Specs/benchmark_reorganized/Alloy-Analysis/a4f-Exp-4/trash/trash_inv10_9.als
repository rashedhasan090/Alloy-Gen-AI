
/* If a file is deleted and it links to another file, that file is also deleted. */
pred inv10_OK {
    all f:File, t:Trash | f in t.link implies f in Trash
}
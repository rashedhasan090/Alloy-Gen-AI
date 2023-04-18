```
/* The set of files in the file system. */
sig File {
  /* A file is potentially a link to other files. */
  link : set File
}
/* The set of files in the trash. */
sig Trash extends File {}
/* The set of protected files. */
sig Protected extends File {}

/* The trash is empty. */
pred inv1 {
  no Trash
}

/* All files are deleted. */
pred inv2 {
  all f: File | f in Trash
}

/* Some file is deleted. */
pred inv3 {
  some Trash
}

/* Protected files cannot be deleted. */
pred inv4 {
  no Protected & Trash
}

/* All unprotected files are deleted. */
pred inv5 {
  all f: File - Protected | f in Trash
}

/* A file links to at most one file. */
pred inv6 {
  lone link
}

/* There is no deleted link. */
pred inv7 {
  no Trash.link
}

/* There are no links. */
pred inv8 {
  no link
}

/* A link does not link to another link. */
pred inv9 {
  no link.link
}

/* If a link is deleted, so is the file it links to. */
pred inv10 {
  all l: Trash.link | l in Trash
}

/*======================================*/

run inv1 for 3
run inv2 for 3
run inv3 for 3
run inv4 for 3
run inv5 for 3
run inv6 for 3
run inv7 for 3
run inv8 for 3
run inv9 for 3
run inv10 for 3
```
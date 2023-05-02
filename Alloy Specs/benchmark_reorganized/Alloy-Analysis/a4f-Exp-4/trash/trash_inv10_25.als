/* The set of files in the file system. */
sig File {
  /* A file is potentially a link to other files. */
  link: set File
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
  File in Trash
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
  File -- Protected in Trash
}

/* A file links to at most one file. */
pred inv6 {
  lone link
}

/* There is no deleted link. */
pred inv7 {
  no link . Trash
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
  link in Trash implies link.link in Trash
}

/* ======= IFF PERFECT ORACLE ======= */
assert inv1_Repaired {
  inv1[] iff no Trash
}

assert inv2_Repaired {
  inv2[] iff File in Trash
}

assert inv3_Repaired {
  inv3[] iff some Trash
}

assert inv4_Repaired {
  inv4[] iff no Protected & Trash
}

assert inv5_Repaired {
  inv5[] iff File -- Protected in Trash
}

assert inv6_Repaired {
  inv6[] iff lone link
}

assert inv7_Repaired {
  inv7[] iff no link . Trash
}

assert inv8_Repaired {
  inv8[] iff no link
}

assert inv9_Repaired {
  inv9[] iff no link.link
}

assert inv10_Repaired {
  inv10[] iff (link in Trash implies link.link in Trash)
}

---- PerfectOracleCommands
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv6_Repaired expect 0
check inv7_Repaired expect 0
check inv8_Repaired expect 0
check inv9_Repaired expect 0
check inv10_Repaired expect 0
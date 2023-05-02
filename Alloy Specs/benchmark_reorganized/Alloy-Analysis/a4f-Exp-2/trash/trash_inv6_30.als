/** The set of files in the file system. **/
sig File {
  /** A file is potentially a link to other files. **/
  link: set File
}
/** The set of files in the trash. **/
sig Trash extends File {}
/** The set of protected files. **/
sig Protected extends File {}
/** The trash is empty. **/
pred inv1 {
  no Trash
}
/** All files are deleted. **/
pred inv2 {
  all f: File | f in Trash
}
/** Some file is deleted. **/
pred inv3 {
  some t: Trash | t in File
}
/** Protected files cannot be deleted. **/
pred inv4 {
  no p: Protected, t: Trash | p = t
}
/** All unprotected files are deleted. **/
pred inv5 {
  no f: (File -- Protected) | f not in Trash
}
/** A file links to at most one file. **/
pred inv6 {
  all x, y: File | x != y && x -> one y in link implies no z: File | z != x && z != y && x -> one z in link
}
/** There is no deleted link. **/
pred inv7 {
  no t: Trash, f: File | t in f.link
}
/** There are no links. **/
pred inv8 {
  no link
}
/** A link does not link to another link. **/
pred inv9 {
  no f: File, l: f.link | l.link != none
}
/** If a link is deleted, so is the file it links to. **/
pred inv10 {
  all t: Trash, f: File | t = f.link implies f in Trash
}

/** Fixed invariant **/
/* a file links to at most one file */
pred inv_6_fixed {
  all x: File |
    all y: File -- x.link |
      no z: File -- x.link -- y |
        x -> y in x.link and (x -> z in x.link implies y = z)
}

check inv_6_fixed

---- PerfectOracleCommands
check inv1 expect 0
check inv2 expect 0
check inv3 expect 0
check inv4 expect 0
check inv5 expect 0
check inv_6_fixed expect 0
check inv7 expect 0
check inv8 expect 0
check inv9 expect 0
check inv10 expect 0
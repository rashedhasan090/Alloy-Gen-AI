There is a bug in the inv14 predicate. Here is the fixed code:

pred inv14_OK {
  all s:Person,c:Class,g:Group | (some c.Groups[g] implies some t:Teacher | t->c in Teaches && g in c.Groups[t])
    => some s.(c.Groups[g])
}

The "s -> g in Groups" part of the original predicate was incorrect, it should've been "c.Groups[g]". Additionally, the "t -> s in Tutors" part was not needed and removed in the fixed code.
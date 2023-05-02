The bug is in inv5. The correct predicate is:

pred inv5 {
    some t: Teacher | t.Teaches != none
}
The bug is in inv2 predicate. The correct predicate is:

pred inv2 { // A component cannot be a part of itself
    all c:Component | c not in c.*parts
}

pred inv5 {
    all s1, s2 : State, e : Event |
        e in s1.trans implies e in s2.trans
}
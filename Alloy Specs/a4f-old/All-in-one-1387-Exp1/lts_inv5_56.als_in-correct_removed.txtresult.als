The bug in the specification is in the inv5 predicate. The comment on the line with "--" suggests that the predicate is correct, but it is actually missing a condition. The corrected predicate should be:

pred inv5 {
    all s1, s2: State |
    (s1.trans).(Event) = (s2.trans).(Event)
}

The condition "(s1.trans).(Event) = (s2.trans).(Event)" ensures that all states have the same events available.
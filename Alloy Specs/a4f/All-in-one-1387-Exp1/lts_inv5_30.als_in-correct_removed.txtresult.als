The bug is in pred inv5, where the comment symbol "--" is placed after the line of code, causing it to be ignored by the Alloy analyzer. The correct version of pred inv5 should be:

pred inv5 {
    all s, s1: State | s.trans.State = s1.trans.State
}
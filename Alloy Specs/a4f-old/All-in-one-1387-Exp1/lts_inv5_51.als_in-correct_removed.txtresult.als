There is a commented out line in pred inv5 that needs to be removed in order to fix the bug:

pred inv5 { all s:State, s1:State | s.trans.State = s1.trans.State -- correct }

should be:

pred inv5 { all s:State, s1:State | s.trans.Event = s1.trans.Event }
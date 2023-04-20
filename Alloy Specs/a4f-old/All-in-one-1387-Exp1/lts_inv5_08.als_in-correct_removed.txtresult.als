The bug in the specification is in the commented out line in inv5. The correct line should be:

```all s1,s2:State | s1.trans.Event = s2.trans.Event --correct```
Fix for bug in inv14:
pred inv14_OK {
  all c:Class, s:Student, t:(Teacher & c.Teaches) | s in (c.Groups).(t.~Teaches) 
}
fixed code:

pred inv5_OK {
	all s:State | all e:Event | e in s.trans 
}
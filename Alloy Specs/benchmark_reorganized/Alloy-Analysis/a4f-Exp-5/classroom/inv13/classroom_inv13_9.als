The fixed code for the bug in inv13 is:

pred inv13_OK {
	all s:Student, t:Teacher | s not in t.^Tutors and t not in s.^Tutors 
}
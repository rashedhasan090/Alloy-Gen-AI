
/* Teachers are assigned at most one class. */
pred inv8 {
	all t:Teacher | lone t.Teaches -> Class 
}
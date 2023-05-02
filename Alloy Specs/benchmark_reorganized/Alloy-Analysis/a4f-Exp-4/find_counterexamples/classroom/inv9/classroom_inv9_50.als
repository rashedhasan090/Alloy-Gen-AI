
pred inv9 {
	all c:Class | lone t:Teacher | t.Teaches = c -> lone t
}
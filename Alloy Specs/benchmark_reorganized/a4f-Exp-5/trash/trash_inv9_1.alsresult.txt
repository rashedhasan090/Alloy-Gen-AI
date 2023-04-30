pred inv9_OK {
	no link.link  
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
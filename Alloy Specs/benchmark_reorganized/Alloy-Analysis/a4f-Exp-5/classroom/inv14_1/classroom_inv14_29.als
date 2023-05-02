pred inv14_OK {
  all c:Class,s:Student | some t:Teacher,g:Group | s in c.Groups[g] and t in c.Teaches and g in t.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
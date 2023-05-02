pred inv14_OK {
  all c : Class | all s : Student | some t : Teacher | (c -> s -> _) in c.Groups implies t -> c in Teaches and s in t.Tutors
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
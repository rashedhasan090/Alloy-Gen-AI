pred inv14_OK {
      all s : Student, c : Class, g : Group | (c -> g) in Groups[s] implies all t : Teacher | t -> c in Teaches implies (t -> s) in Tutors[g]
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
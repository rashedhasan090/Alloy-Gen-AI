pred inv14_OK {
      all s : Student, c : Class, g : Group | (c -> s -> g in Groups) implies some t : Teacher | t -> s in Tutors and t -> c in Teaches 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
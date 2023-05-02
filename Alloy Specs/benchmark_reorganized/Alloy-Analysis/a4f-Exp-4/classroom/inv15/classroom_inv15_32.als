
pred inv14_OK {
    all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and s -> t in Tutors implies t -> c in Teaches
}
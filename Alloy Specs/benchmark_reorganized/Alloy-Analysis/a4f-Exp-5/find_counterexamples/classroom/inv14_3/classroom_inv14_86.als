pred inv14_OK {
 all s : Person, c : Class, g : Group | g in c.Groups.s implies some t : Teacher | t -> c in Teaches and t -> s in Tutors and c -> s -> g in Groups 
}
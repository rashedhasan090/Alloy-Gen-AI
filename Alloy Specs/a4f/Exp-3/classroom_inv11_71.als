sig Person  {
	Tutors : set Person,
	Teaches : set Class
}
sig Group {}
sig Class  {
	Groups : Person -> Group
}
sig Teacher extends Person  {}
sig Student extends Person  {}
pred inv1 {
	Person in Student 
}
pred inv2 {
	no Teacher 
}
pred inv3 {
	no Student & Teacher 
}
pred inv4 {
	Person in (Student + Teacher) 
}
pred inv5 {
	some Teacher.Teaches 
}
pred inv6 {
	Teacher in Teaches.Class 
}
pred inv7 {
	Class in Teacher.Teaches 
}
pred inv8 {
	all t:Teacher | lone t.Teaches 
}
pred inv9 {
	all c:Class | lone Teaches.c & Teacher 
}
pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) 
}
pred inv11 {
 all c: Class | some t: Teacher , p: Person , g: Group| (c->p->g in Groups) implies (t->c in Teaches) 
}
pred inv12 {
	all t : Teacher | some (t.Teaches).Groups 
}
pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student 
}
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors
}
pred inv15 {
	all s : Person | some Teacher & ^Tutors.s
pred inv1_OK {
  Person in Student 
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
pred inv2_OK {
  no Teacher 
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
pred inv3_OK {
  no Student & Teacher 
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
pred inv4_OK {
 Person in (Student + Teacher) 
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
pred inv5_OK {
  some Teacher.Teaches 
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
pred inv6_OK {
  Teacher in Teaches.Class 
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
pred inv7_OK {
  Class in Teacher.Teaches 
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
pred inv8_OK {
  all t:Teacher | lone t.Teaches 
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
pred inv9_OK {
  all c:Class | lone Teaches.c & Teacher 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
pred inv10_OK {
  all c:Class, s:Student | some s.(c.Groups) 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
pred inv11_OK {
  all c : Class | (some c.Groups) implies some Teacher & Teaches.c 
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
pred inv12_OK {
 all t : Teacher | some (t.Teaches).Groups 
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
pred inv13_OK {
  Tutors.Person in Teacher and Person.Tutors in Student  
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
pred inv14_OK {
      all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors 
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
pred inv15_OK {
  all s : Person | some Teacher & ^Tutors.s 
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}
 check inv1_Repaired expect 0
 check inv2_Repaired expect 0
 check inv3_Repaired expect 0 
 check inv4_Repaired expect 0
 check inv5_Repaired expect 0
 check inv6_Repaired expect 0
 check inv7_Repaired expect 0
 check inv8_Repaired expect 0
 check inv9_Repaired expect 0
 check inv10_Repaired expect 0
 check inv11_Repaired expect 0
 check inv12_Repaired expect 0
 check inv13_Repaired expect 0
 check inv14_Repaired expect 0
 check inv15_Repaired expect 0
pred repair_pred_1{inv11[] iff inv11_OK[] }
run repair_pred_1
assert repair_assert_1{inv11[] iff inv11_OK[] }
check repair_assert_1

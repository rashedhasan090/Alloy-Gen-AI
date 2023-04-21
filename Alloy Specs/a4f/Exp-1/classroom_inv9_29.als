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
	Person in Student --correct





}

pred inv2 {
	no Teacher --correct



}

pred inv3 {
	no Student & Teacher --correct









}

pred inv4 {
	Person in (Student + Teacher) --correct












}

pred inv5 {
	some Teacher.Teaches --correct




































}

pred inv6 {
	Teacher in Teaches.Class --correct
























}

pred inv7 {
	Class in Teacher.Teaches --correct



















}

pred inv8 {
	all t:Teacher | lone t.Teaches --correct


























}

pred inv9 {
--	all c:Class | lone Teaches.c & Teacher --correct




























 all c:Class,p:Teacher | lone Teaches.c and lone p.Teaches 


















}

pred inv10 {
	all c:Class, s:Student | some s.(c.Groups) --correct
























}

pred inv11 {
	all c : Class | (some c.Groups) implies some Teacher & Teaches.c --correct












































































































































































































































}

pred inv12 {
	all t : Teacher | some (t.Teaches).Groups --correct













































































}

pred inv13 {
	Tutors.Person in Teacher and Person.Tutors in Student --correct




































}

pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors


































































































































































}

pred inv15 {
	all s : Person | some Teacher & ^Tutors.s



















































pred inv1_OK {
  Person in Student --correct
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
---------
pred inv2_OK {
  no Teacher --correct
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
--------
pred inv3_OK {
  no Student & Teacher --correct
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
--------
pred inv4_OK {
 Person in (Student + Teacher) --correct
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
--------
pred inv5_OK {
  some Teacher.Teaches --correct
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
--------
pred inv6_OK {
  Teacher in Teaches.Class --correct
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}
--------
pred inv7_OK {
  Class in Teacher.Teaches --correct
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
--------
pred inv8_OK {
  all t:Teacher | lone t.Teaches --correct
}
assert inv8_Repaired {
    inv8[] iff inv8_OK[]
}
--------
pred inv9_OK {
  all c:Class | lone Teaches.c & Teacher --correct
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}
--------
pred inv10_OK {
  all c:Class, s:Student | some s.(c.Groups) --correct
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}
--------
pred inv11_OK {
  all c : Class | (some c.Groups) implies some Teacher & Teaches.c --correct
}
assert inv11_Repaired {
    inv11[] iff inv11_OK[]
}
--------
pred inv12_OK {
 all t : Teacher | some (t.Teaches).Groups --correct
}
assert inv12_Repaired {
    inv12[] iff inv12_OK[]
}
--------
pred inv13_OK {
  Tutors.Person in Teacher and Person.Tutors in Student  --correct
}
assert inv13_Repaired {
    inv13[] iff inv13_OK[]
}
--------
pred inv14_OK {
      all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies t -> s in Tutors --correct
}
assert inv14_Repaired {
    inv14[] iff inv14_OK[]
}
--------
pred inv15_OK {
  all s : Person | some Teacher & ^Tutors.s --correct
}
assert inv15_Repaired {
    inv15[] iff inv15_OK[]
}
--------

--- PerfectOracleCommands
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
pred repair_pred_1{inv9[] iff inv9_OK[] }
run repair_pred_1
assert repair_assert_1{inv9[] iff inv9_OK[] }
check repair_assert_1

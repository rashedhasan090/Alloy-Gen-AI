//fixed inv7 predicate
pred inv7 {
	all s1,s2:State, e1,e2:Event  | s1->e1->s2 in trans implies 
        (some s3:State | s2->e2->s3 in trans and s3 in Init)
}
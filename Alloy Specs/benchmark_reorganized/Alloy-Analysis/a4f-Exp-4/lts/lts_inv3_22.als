
pred inv3 {
    all s:State | lone e:Event | e->s in s.trans 
}
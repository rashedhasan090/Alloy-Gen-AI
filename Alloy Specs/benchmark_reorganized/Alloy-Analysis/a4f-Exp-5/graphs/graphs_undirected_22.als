sig Node {
	adj : set Node
}
pred undirected {
	all n:Node | n.adj = n.adj~
}
pred oriented {
	no adj & ~adj
}
pred acyclic {
	all n:Node | n !in n.^adj
}
pred complete {
	all n:Node | all m:Node -- n | n->m in adj
}
pred noLoops {
	no iden & adj
}
pred weaklyConnected {
	all n,m:Node | n in m.*(adj+adj~)
}
pred stonglyConnected {
	all n:Node | all m:Node | n->m in adj implies m->n in adj
}
pred transitive {
	all n:Node | all m:Node | all o:Node | n->o in adj and o->m in adj implies n->m in adj
}

pred undirectedOK {
	adj = ~adj
}
assert undirectedRepaired {
    undirected[] iff undirectedOK[]
}

pred orientedOK {
	no adj & ~adj 
}
assert orientedRepaired {
    oriented[] iff orientedOK[]
}

pred acyclicOK {
	all a:Node | a not in a.^adj
}
assert acyclicRepaired {
   acyclic[]  iff acyclicOK[]
}

pred completeOK {
	all n:Node | all m:Node -- n | n->m in adj
}
assert completeRepaired {
    complete[] iff completeOK[]
}

pred noLoopsOK {
	no iden & adj
}
assert noLoopsRepaired {
   noLoops[]  iff noLoopsOK[]
}

pred weaklyConnectedOK {
	all n,m:Node | n in m.*(adj+adj~)
}
assert weaklyConnectedRepaired {
   weaklyConnected[]  iff weaklyConnectedOK[]
}

pred stonglyConnectedOK {
	all n:Node | all m:Node | n->m in adj implies m->n in adj
}
assert stonglyConnectedRepaired {
   stonglyConnected[]  iff stonglyConnectedOK[]
}

pred transitiveOK {
	all n:Node | all m:Node | all o:Node | n->o in adj and o->m in adj implies n->m in adj
}
assert transitiveRepaired {
    transitive[] iff transitiveOK[]
}

check undirectedRepaired expect 0
check orientedRepaired expect 0
check acyclicRepaired expect 0
check completeRepaired expect 0
check noLoopsRepaired expect 0
check weaklyConnectedRepaired expect 0
check stonglyConnectedRepaired expect 0
check transitiveRepaired expect 0

pred repair_pred_1{
	undirected[] iff undirectedOK[]
}
run repair_pred_1
assert repair_assert_1{undirected[] iff undirectedOK[] }
check repair_assert_1
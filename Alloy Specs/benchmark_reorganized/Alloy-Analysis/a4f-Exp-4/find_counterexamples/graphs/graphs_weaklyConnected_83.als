
pred completeOK {
 	all n:Node | n.adj = Node -- n
}

Then the corresponding assert completeRepaired should be updated accordingly:

assert completeRepaired {
    complete[] iff completeOK[]
}
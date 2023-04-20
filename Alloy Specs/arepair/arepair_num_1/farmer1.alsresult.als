The bug in the specification is in the "crossRiver" predicate. Specifically, in the case where the farmer takes no items across the river, the fix replaces "from' = from - Farmer && to' = to - to.eats + Farmer" with "from' = from - Farmer - from'.eats && to' = to + Farmer". 

Similarly, in the case where the farmer takes one item, the fix replaces "from' = from - Farmer - item && to' = to - to.eats + Farmer + item" with "from' = from - Farmer - item - from'.eats && to' = to + Farmer + item".

The bug was that the original model considers eating to happen in the "to" set, rather than the "from" set. This stops the farmer from leaving and letting the fox eat the chicken without the farmer coming back.

pred inv3_OK { // The position where a component is assembled must have at least one robot
	some r:Robot | r.rposition = Component.cposition
}

The rest of the specification is correct.
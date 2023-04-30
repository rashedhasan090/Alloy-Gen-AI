/* Fixed code */
sig State {
        trans : Event -> lone State //fixed here by using lone
}

pred inv5 {
    all s:State | all e:Event | some e<:s.trans 
}
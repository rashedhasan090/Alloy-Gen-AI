There is a bug in inv3_OK. The condition "w1 != w2" is not sufficient to ensure that w1 and w2 have different ids. Instead, we need to compare w1.source and w2.source to check if they are different. Here is the fixed code:

pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source != w2.source) implies no w1.ids & w2.ids 
}
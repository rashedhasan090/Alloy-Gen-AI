There is a bug in inv2. Specifically, the condition for a work being in a user's profile should also allow for the work being added by some external source that is not an institution. The fixed inv2 is:

pred inv2 {
	all u:User, w:Work | w in u.profile implies ((u in w.source) or (some s:Source -- Institution | s in w.source))
}
pred inv7_OK {
	all f,g:File | (f->g in link) implies (f not in Trash or g not in Trash)
}
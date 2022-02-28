module main

import vaker

struct St {
	Bs
	a string ['vaker:str_len=10']
}

struct Bs {
	a string
}

interface Fs {
	a string
}

fn main() {
	a := map[int]string{}
	st := St{}
	vaker.fake_data(&a)
	vaker.fake_data(&st)
	println(a)
	println(st)
}

module main

import vaker

struct St {
	Bs
	a string ['vaker:str_len=5']
	b string
}

struct Bs {
	Fs
	a string ['vaker:skip']
}

struct Fs {
	a map[int]string
}

fn main() {
	a := map[int]string{}
	st := St{}
	vaker.fake_data(&a)
	vaker.fake_data(&st)
	println(a)
	println(st)
}

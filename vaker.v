module main

import vaker

struct St {
	Bs
	a string ['vaker:str_len=10']
}

struct Bs {
	Fs
	a string
}

struct Fs {
	a map[int]string
}

fn main() {
	a := map[int]string{}
	st := St{}
	b := [5]int{}
	vaker.fake_data(&a)
	vaker.fake_data(&st)
	vaker.fake_data(&b)
	println(a)
	println(st)
}

module main

import vaker
import math

struct St {
	Bs
	a    string ['vaker:str_len=5']
	lat  f32    ['vaker:lat']
	long f64    ['vaker:long']
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
	st := St{
		long: math.max_f64
	}
	vaker.fake_data(&a)
	vaker.fake_data(&st)
	println(a)
	println(st)
}

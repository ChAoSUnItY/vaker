module main

import vaker

struct St {
	Bs
	a    string ['vaker:uuid_digit']
	lat  f32    ['vaker:lat']
	long f64    ['vaker:long']
}

struct Bs {
	Fs
	a string ['vaker:skip']
}

fn main() {
	st := St{}
	vaker.fake_data(&st)
	println(st)
}

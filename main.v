module main

import vaker

struct St {
	Bs
	a    string ['vaker:amount_with_currency']
	lat  f32    ['vaker:lat']
	long f64    ['vaker:long']
}

struct Bs {
	a string ['vaker:skip']
}

fn main() {
	st := St{}
	vaker.fake_data(&st)
	println(st)
}

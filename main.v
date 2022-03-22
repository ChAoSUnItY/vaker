module main

import vaker
import time

struct St {
	Bs
	time time.Time ['vaker:unix_time']
	a    string    ['vaker:jwt']
	lat  f32       ['vaker:lat']
	long f64       ['vaker:long']
}

struct Bs {
	a string ['vaker:cc_type']
}

fn main() {
	st := St{}
	vaker.fake_data(&st)
	println(st)
}

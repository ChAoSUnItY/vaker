module main

import vaker

struct St {
	a string
}

fn main() {	
	st := St{}
	vaker.fake_data(&st)
	println(st)
}

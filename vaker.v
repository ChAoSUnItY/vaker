module main

import vaker

struct St {
	a string
	b Bs
}

struct Bs {
	a string
}

interface Fs {
	a string
}

fn main() {
	mut s := [St{}, St{}]
	a := ['', '']
	df := vaker.DataFaker{
		lb: &vaker.lb_jpn
	}
	vaker.fake_data_wdf(&s, &df)
	vaker.fake_data(&a)
	println(s)
	println(a)
}

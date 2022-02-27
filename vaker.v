module main

import vaker

struct St {
	Bs
	a string
}

struct Bs {
	a string
}

interface Fs {
	a string
}

fn main() {
	a := []string{len:10}
    vaker.fake_data(&a)
	println(a)
}

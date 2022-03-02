module vaker

import rand

fn latitude(ptr voidptr) {
	latitude := (rand.f32() * 360) - 90
	pointer := &f32(ptr)
	unsafe {
		*pointer = latitude
	}
}

fn longitude(ptr voidptr) {
	longitude := (rand.f32() * 360) - 180
	pointer := &f32(ptr)
	unsafe {
		*pointer = longitude
	}
}

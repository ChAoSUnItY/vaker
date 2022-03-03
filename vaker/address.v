module vaker

import rand

[inline]
fn latitude(ptr voidptr) {
	latitude := (rand.f32() * 360) - 90
	pointer := &f32(ptr)
	unsafe {
		*pointer = latitude
	}
}

[inline]
fn longitude(ptr voidptr) {
	longitude := (rand.f32() * 360) - 180
	pointer := &f32(ptr)
	unsafe {
		*pointer = longitude
	}
}

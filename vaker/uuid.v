module vaker

import rand

[inline]
pub fn hyphenated(ptr voidptr) {
	pointer := &string(ptr)
	unsafe {
		*pointer = rand.uuid_v4()
	}
}

[inline]
pub fn digit(ptr voidptr) {
	pointer := &string(ptr)
	unsafe {
		*pointer = rand.uuid_v4().replace('-', '')
	}
}

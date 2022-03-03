module vaker

import rand

[inline]
pub fn hyphenated(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = rand.uuid_v4()
	}
}

[inline]
pub fn digit(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = rand.uuid_v4().replace('-', '')
	}
}

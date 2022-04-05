module vaker

import rand

[inline]
pub fn hyphenated(ptr PtrInfo) {
	unsafe {
		cast_assign(ptr, rand.uuid_v4())
	}
}

[inline]
pub fn digit(ptr PtrInfo) {
	unsafe {
		cast_assign(ptr, rand.uuid_v4().replace('-', ''))
	}
}

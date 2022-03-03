module vaker

import rand

[inline]
pub fn latitude(ptr PtrInfo) {
	latitude := (rand.f32() * 360) - 90
	match ptr.sz {
		4 {
			pointer := &f32(ptr.ptr)
			unsafe {
				*pointer = latitude
			}
		}
		8 {
			pointer := &f64(ptr.ptr)
			unsafe {
				*pointer = latitude
			}
		}
		else {}
	}
}

[inline]
pub fn longitude(ptr PtrInfo) {
	longitude := (rand.f32() * 360) - 180
	match ptr.sz {
		4 {
			pointer := &f32(ptr.ptr)
			unsafe {
				*pointer = longitude
			}
		}
		8 {
			pointer := &f64(ptr.ptr)
			unsafe {
				*pointer = longitude
			}
		}
		else {}
	}
}

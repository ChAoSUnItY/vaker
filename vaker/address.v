module vaker

import rand

[inline]
pub fn latitude(ptr PtrInfo) {
	latitude := (rand.f32() * 360) - 90
	unsafe {
		match ptr.sz {
			4 {
				cast_assign<f32>(ptr, latitude)
			}
			8 {
				cast_assign<f64>(ptr, latitude)
			}
			else {}
		}
	}
}

[inline]
pub fn longitude(ptr PtrInfo) {
	longitude := (rand.f32() * 360) - 180
	unsafe {
		match ptr.sz {
			4 {
				cast_assign<f32>(ptr, longitude)
			}
			8 {
				cast_assign<f64>(ptr, longitude)
			}
			else {}
		}
	}
}

module vaker

import rand
import arrays

[inline]
pub fn phone_number(ptr PtrInfo) {
	s := arrays.fold<byte, string>(rand.bytes(10) or { []byte{len: 10} }, '', fn (s string, b byte) string {
		return s + b.str()
	})
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '${s[..3]}-${s[3..6]}-${s[6..10]}'
	}
}

module vaker

import rand
import strings

[inline]
pub fn rand_digit_string(len int) string {
	if len <= 0 {
		return ''
	}
	mut b := strings.new_builder(len)

	for _ in 0 .. len {
		b.write_byte(byte(48 + rand.intn(10) or { 0 }))
	}

	return b.str()
}

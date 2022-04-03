module vaker

import rand
import strings

const (
	box_digits1 = ['777', '888']
	box_digits2 = ['7', '8']
)

[inline]
pub fn phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(10)
	for _ in 0 .. 10 {
		s.write_string((rand.intn(10) or { 0 }).str())
	}
	str := s.str()
	unsafe {
		cast_assign(ptr, '${str[..3]}-${str[3..6]}-${str[6..]}')
	}
}

[inline]
pub fn toll_free_phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(9)
	for _ in 0 .. 9 {
		s.write_string((rand.intn(10) or { 0 }).str())
	}
	str := s.str()
	unsafe {
		box := rand_element(vaker.box_digits1)
		cast_assign(ptr, '($box) ${str[..3]}-${str[3..]}')
	}
}

[inline]
pub fn e164_phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(10)
	for _ in 0 .. 9 {
		s.write_string((rand.intn(10) or { 0 }).str())
	}
	str := s.str()
	unsafe {
		box := rand_element(vaker.box_digits2)
		cast_assign(ptr, '+$box$str')
	}
}

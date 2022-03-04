module vaker

import rand
import strings

const (
	box_digits = ['777', '888']
)

[inline]
pub fn phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(10)
	for i in 0 .. 10 {
		s.write_string((rand.intn(9) or { 0 }).str())
	}
	str := s.str()
	pointer := &string(ptr.ptr)
	unsafe {
		s.free()
		*pointer = '${str[..3]}-${str[3..6]}-${str[6..]}'
	}
}

[inline]
pub fn toll_free_phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(9)
	for i in 0 .. 9 {
		s.write_string((rand.intn(9) or { 0 }).str())
	}
	str := s.str()
	pointer := &string(ptr.ptr)
	unsafe {
		s.free()
		box := vaker.box_digits[rand.intn(2) or { 1 }]
		*pointer = '($box) ${str[..3]}-${str[3..]}'
	}
}

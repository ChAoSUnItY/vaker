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
	pointer := &string(ptr.ptr)
	unsafe {
		s.free()
		*pointer = '${str[..3]}-${str[3..6]}-${str[6..]}'
	}
}

[inline]
pub fn toll_free_phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(9)
	for _ in 0 .. 9 {
		s.write_string((rand.intn(10) or { 0 }).str())
	}
	str := s.str()
	pointer := &string(ptr.ptr)
	unsafe {
		s.free()
		box := vaker.box_digits1[rand.intn(2) or { 1 }]
		*pointer = '($box) ${str[..3]}-${str[3..]}'
	}
}

[inline]
pub fn e164_phone_number(ptr PtrInfo) {
	mut s := strings.new_builder(10)
	for _ in 0 .. 9 {
		s.write_string((rand.intn(10) or { 0 }).str())
	}
	str := s.str()
	pointer := &string(ptr.ptr)
	unsafe {
		s.free()
		box := vaker.box_digits2[rand.intn(2) or { 1 }]
		*pointer = '+$box$str'
	}
}

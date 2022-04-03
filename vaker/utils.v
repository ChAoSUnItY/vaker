module vaker

import rand
import strings
import encoding.utf8

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

pub fn rand_string(len int, lb &LangaugeBoundary) string {
	mut runes := []rune{cap: len}

	for i, _ := 0, 0; i < len; {
		mut b := rand.int_in_range(lb.start, lb.end) or { panic(err) }
		for lb.exclude.contains(b) {
			b = rand.int_in_range(lb.start, lb.end) or { panic(err) }
		}
		runes << rune(b)
		i++
	}

	return runes.string()
}

[inline]
pub fn rand_element<T>(arr []T) T {
	return arr[rand.intn(arr.len) or { 0 }]
}

pub fn insert_sep(str string, sep string, step int) string {
	len := str.len / step * (step + sep.len) - 1
	mut b := strings.new_builder(len)
	for i in 0 .. str.len {
		if i != 0 && i % step == 0 {
			b.write_string(sep)
		}

		b.write_string(utf8.raw_index(str, i))
	}
	return b.str()
}

[inline]
pub fn is_type<T>(ptr PtrInfo) bool {
	return T.idx == ptr.type_idx
}

[inline]
pub fn cast<T>(ptr PtrInfo) &T {
	return &T(ptr.ptr)
}

[inline; unsafe]
pub fn cast_assign<T>(ptr PtrInfo, value T) {
	unsafe {
		*(&T(ptr.ptr)) = value
	}
}

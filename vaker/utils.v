module vaker

import rand
import strings
import encoding.utf8

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

pub fn rand_string(len int, lb &LangaugeBoundary) string {
	mut runes := []rune{cap: len}

	for i, _ := 0, 0; i < len; {
		runes << rune(rand.int_in_range(lb.start, lb.end) or { panic(err) })
		i++
	}

	return runes.string()
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

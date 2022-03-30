module main

import vaker

struct Example {
	my_word string ['chaos:my_word']
	int_field int ['chaos:multiple_type']
	i64_field i64 ['chaos:multiple_type']
}

fn main() {
	mut custom_df := vaker.new_df()
	custom_df.register('chaos')
	custom_df.register_fn('chaos', 'my_word', my_word) ?
	custom_df.register_fn('chaos', 'multiple_type', multiple_type) ?
	ex := Example{}
	vaker.fake_data_wdf(&ex, &custom_df)
	println(ex)
}

fn my_word(ptr vaker.PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = 'I am ChAoS!'
	}
}

fn multiple_type(ptr vaker.PtrInfo) {
	unsafe {
	if ptr.sz == 4 {
		// int
		pointer := &int(ptr.ptr)
		*pointer = 50
	} else {
		// you should assume it's long, otherwise, there'll be no other possible castings
		pointer := &i64(ptr.ptr)
		*pointer = 100
	}
	}
}

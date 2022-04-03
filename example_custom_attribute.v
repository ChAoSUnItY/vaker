module main

import vaker

struct Example {
	my_word   string ['chaos:my_word']
	int_field int    ['chaos:multiple_type']
	i64_field i64    ['chaos:multiple_type']
}

fn main() {
	mut custom_df := vaker.new_df()
	custom_df.register('chaos')
	custom_df.register_fn<string>('chaos', 'my_word', my_word) ?
	custom_df.register_fn<int>('chaos', 'multiple_type', multiple_type) ?
	custom_df.add_type<i64>('chaos', 'multiple_type') ?
	ex := Example{}
	vaker.fake_data_wdf(&ex, &custom_df)
	println(ex)

	//  Example{
	//      my_word: 'I am ChAoS!'
	//      int_field: 50
	//      i64_field: 100
	//  }
}

fn my_word(ptr vaker.PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = 'I am ChAoS!'
	}
}

fn multiple_type(ptr vaker.PtrInfo) {
	// unsafe {
	// 	if ptr.sz == 4 {
	// 		// int
	// 		pointer := &int(ptr.ptr)
	// 		*pointer = 50
	// 	} else {
	// 		// you should assume it's long, otherwise, there'll be no other possible castings
	// 		pointer := &i64(ptr.ptr)
	// 		*pointer = 100
	// 	}
	// }

	// alternative: check by type idx (Enhanced way to check type)
	unsafe {
		if vaker.is_type<int>(ptr.type_idx) {
			// int
			pointer := &int(ptr.ptr)
			*pointer = 50
		} else if vaker.is_type<i64>(ptr.type_idx) {
			// i64
			pointer := &i64(ptr.ptr)
			*pointer = 100
		}
		// You don't have to handle the unmatched types, they've been checked before faking phase
	}
}

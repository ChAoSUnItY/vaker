module main

import vaker

struct Example {
	my_word string ['chaos:my_word']
}

fn main() {
	mut custom_df := vaker.new_df()
	custom_df.register('chaos')
	custom_df.register_fn('chaos', 'my_word', my_word) ?
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

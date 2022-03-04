module vaker

[params]
struct PtrInfo {
	ptr voidptr
	sz  usize
}

pub struct DataFaker {
mut:
	lb                  &LangaugeBoundary = &lb_eng
	str_len             int = 10
	max_arr_len         int = 10
	min_arr_len         int
	max_map_len         int = 10
	min_map_len         int
	rand_max_sz         i64 = 100
	rand_min_sz         i64
	rand_max_usz        u64 = 100
	rand_min_usz        u64
	rand_max_fsz        f64 = 100
	rand_min_fsz        f64
	primitive_invokers  PrimitiveInvokers       = primitive_invokers
	attribute_functions map[string]fn (PtrInfo) = {
		'e164_phone_number':      e164_phone_number
		'lat':                    latitude
		'long':                   longitude
		'phone_number':           phone_number
		'toll_free_phone_number': toll_free_phone_number
		'uuid_digit':             digit
		'uuid_hyphenated':        hyphenated
	}
	current_attribute_function &fn (PtrInfo) = voidptr(0)
}

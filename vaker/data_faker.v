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
		'amount':                 amount
		'amount_with_currency':   amount_with_currency
		'cc_number':              cc_number
		'cc_type':                cc_type
		'century':                century
		'currency':               currency
		'date':                   date
		'day_of_week':            day_of_week
		'domain_name':            domain_name
		'e164_phone_number':      e164_phone_number
		'email':                  email
		'ipv4':                   ipv4
		'ipv6':                   ipv6
		'jwt':                    jwt
		'lat':                    latitude
		'long':                   longitude
		'mac_address':            mac_address
		'month':                  month
		'password':               password
		'period':                 period
		'phone_number':           phone_number
		'timestamp':              timestamp
		'timezone':               timezone
		'toll_free_phone_number': toll_free_phone_number
		'unix_time':              unix_time
		'url':                    url
		'user_name':              user_name
		'uuid_digit':             digit
		'uuid_hyphenated':        hyphenated
		'year':                   year
	}
	current_attribute_function &fn (PtrInfo) = voidptr(0)
}

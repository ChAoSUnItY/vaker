module vaker

[params]
struct PtrInfo {
pub:
	ptr      voidptr
	sz       usize // Used for very limited type checking cases, commonly when multiple acceptable types has unique sizes
	type_idx int   // Used for common type checking cases when size checking does not satisfy
}

struct ExternalAttributeFn {
	function fn (PtrInfo)
mut:
	acceptable_type_names []string
	acceptable_type_idxs  []int
}

[inline]
fn (mut eaf ExternalAttributeFn) add_type(type_name string, type_idx int) {
	eaf.acceptable_type_names << type_name
	eaf.acceptable_type_idxs << type_idx
}

// DataFaker holds various data faking settings for vaker to process with
pub struct DataFaker {
mut:
	lb                           &LangaugeBoundary = &lb_eng
	str_len                      int = 10
	max_arr_len                  int = 10
	min_arr_len                  int
	max_map_len                  int = 10
	min_map_len                  int
	rand_max_sz                  i64 = 100
	rand_min_sz                  i64
	rand_max_usz                 u64 = 100
	rand_min_usz                 u64
	rand_max_fsz                 f64 = 100
	rand_min_fsz                 f64
	primitive_invokers           PrimitiveInvokers = primitive_invokers
	external_attribute_functions map[string]map[string]ExternalAttributeFn = {}
	attribute_functions          map[string]fn (PtrInfo) = {
		'amount':                 amount
		'amount_with_currency':   amount_with_currency
		'cc_number':              cc_number
		'cc_type':                cc_type
		'century':                century
		'chinese_first_name':     chinese_first_name
		'chinese_last_name':      chinese_last_name
		'chinese_name':           chinese_name
		'currency':               currency
		'date':                   date
		'day_of_week':            day_of_week
		'domain_name':            domain_name
		'e164_phone_number':      e164_phone_number
		'email':                  email
		'first_name':             first_name
		'first_name_female':      first_name_female
		'first_name_male':        first_name_male
		'gender':                 gender
		'ipv4':                   ipv4
		'ipv6':                   ipv6
		'jwt':                    jwt
		'last_name':              last_name
		'lat':                    latitude
		'long':                   longitude
		'mac_address':            mac_address
		'month':                  month
		'name':                   name
		'paragraph':              paragraph
		'password':               password
		'period':                 period
		'phone_number':           phone_number
		'sentence':               sentence
		'title_female':           title_female
		'title_male':             title_male
		'time':                   time
		'timestamp':              timestamp
		'timezone':               timezone
		'toll_free_phone_number': toll_free_phone_number
		'unix_time':              unix_time
		'url':                    url
		'user_name':              user_name
		'uuid_digit':             digit
		'uuid_hyphenated':        hyphenated
		'word':                   word
		'year':                   year
	}
	current_attribute_function &fn (PtrInfo) = voidptr(0)
}

// Creates a new DataFaker from global one
[inline]
pub fn new_df() DataFaker {
	return DataFaker{
		...default_df
	}
}

[inline]
pub fn (mut df DataFaker) register(unit_name string) {
	df.external_attribute_functions[unit_name] = {}
}

[inline]
pub fn (df DataFaker) has_unit(unit_name string) bool {
	return unit_name in df.external_attribute_functions
}

// register an attribute function with unit name and attribute name, must specify at least an acceptable type for attribute function to satisfy with
pub fn (mut df DataFaker) register_fn<T>(unit_name string, attribute_name string, fn_ptr fn (PtrInfo)) ? {
	if unit_name !in df.external_attribute_functions {
		return error('Unit $unit_name does not exist, call `DataFaker#register(string)` first')
	}

	if attribute_name in df.external_attribute_functions[unit_name] {
		return error('Attribute $attribute_name in unit $unit_name already exist')
	}

	df.external_attribute_functions[unit_name][attribute_name] = ExternalAttributeFn{fn_ptr, [
		T.name,
	], [T.idx]}
}

pub fn (mut df DataFaker) add_type<T>(unit_name string, attribute_name string) ? {
	if unit_name !in df.external_attribute_functions {
		return error('Unit $unit_name does not exist, call `DataFaker#register(string)` first')
	}

	if attribute_name !in df.external_attribute_functions[unit_name] {
		return error('Attribute $attribute_name does not exist in unit $unit_name')
	}

	df.external_attribute_functions[unit_name][attribute_name].add_type(T.name, T.idx)
}

[inline]
pub fn (df DataFaker) has_attribute(unit_name string, attribute_name string) bool {
	return df.has_unit(unit_name) && attribute_name in df.external_attribute_functions[unit_name]
}

module vaker

import arrays { binary_search }
import time

type Attribute = map[string]map[string][]string

const (
	builtin_attrs = [
		'amount',
		'amount_with_currency',
		'cc_number',
		'cc_type',
		'century',
		'chinese_first_name',
		'chinese_last_name',
		'chinese_name',
		'currency',
		'date',
		'day_of_week',
		'domain_name',
		'e164_phone_number',
		'email',
		'first_name',
		'first_name_female',
		'first_name_male',
		'gender',
		'ipv4',
		'ipv6',
		'jwt',
		'last_name',
		'lat',
		'long',
		'mac_address',
		'month',
		'name',
		'paragraph',
		'password',
		'period',
		'phone_number',
		'sentence',
		'skip',
		'str_len',
		'time',
		'timestamp',
		'timezone',
		'title_female',
		'title_male',
		'toll_free_phone_number',
		'unix_time',
		'url',
		'user_name',
		'uuid_digit',
		'uuid_hyphenated',
		'word',
		'year',
	]
)

// Dummy struct for get_attrs
struct Struct {
}

// get_attrs can effectively collect valid attributes by asserting type symbol T
// For example: attribute `str_len` would eprintln when type symbol T is not `string`
[inline]
fn get_attrs[T](_ T, fd &FieldData, df &DataFaker) (Attribute, []IError) {
	// Process vaker builtin attribute functions first
	attrs := fd.attrs.filter(it.starts_with('vaker')).map(it.trim_string_left('vaker:')).map(it.split_any(':='))
	wrong_type := fn (attribute string, type_name string) IError {
		return error('Attribute `${attribute}` could not apply on type ${type_name}')
	}
	mut errors := []IError{cap: 4}
	// map[unit_name]map[attribute_name][]args
	mut checked_attrs := map[string]map[string][]string{}
	{
		cap:
		1
	}
	for attr in attrs {
		attribute := attr[0] or {
			errors << error('Expect a vaker attribute after `vaker:`')
			continue
		}
		binary_search(vaker.builtin_attrs, attribute) or {
			errors << error('Unexpected vaker attribute ${attribute}')
			continue
		}

		match attribute {
			'amount', 'currecy', 'lat', 'long' {
				$if T !is f32 && T !is f64 {
					errors << wrong_type(attribute, T.name)
					continue
				}
			}
			'amount_with_currency', 'cc_number', 'cc_type', 'century', 'date', 'email',
			'day_of_week', 'domain_name', 'ipv4', 'ipv6', 'jwt', 'mac_address', 'month',
			'password', 'period', 'sentence', 'timestamp', 'timezone', 'phone_number', 'paragraph',
			'toll_free_phone_number', 'url', 'user_name', 'uuid_digit', 'uuid_hyphenated', 'word',
			'year', 'title_female', 'title_male', 'chinese_first_name', 'chinese_last_name',
			'chinese_name', 'first_name', 'first_name_female', 'first_name_male', 'gender',
			'last_name', 'name' {
				$if T !is string {
					errors << wrong_type(attribute, T.name)
					continue
				}
			}
			'str_len' {
				$if T is string {
					if attr.len != 2 {
						errors << error('Attribute `str_len` requires 1 integer argument')
						continue
					}
				} $else {
					errors << wrong_type(attribute, T.name)
					continue
				}
			}
			'skip' {
				if attr.len != 1 {
					errors << error('Unexpected arguments ${attribute[1..]}')
					continue
				} else if checked_attrs.len != 0 {
					// Redundant attributes: Having `skip` attribute while more than one attributes exist at same field
					errors << error('Redundant attributes, remove other attributes')
					continue
				}
			}
			'unix_time' {
				$if T !is i64 && T !is time.Time {
					errors << wrong_type(attribute, T.name)
				}
			}
			else {
				// Unreachable
			}
		}

		checked_attrs['vaker'][attribute] = attr[1..]
	}
	for custom_attrs in fd.attrs.filter(!it.starts_with('vaker')) {
		split := custom_attrs.split(':')
		if split.len != 2 {
			errors << error('Invalid custom attribute format, valid example: `unit_name:attr_name`')
			continue
		}
		unit_name, attr_name := split[0], split[1]
		if df.has_attribute(unit_name, attr_name) {
			eaf := df.external_attribute_functions[unit_name][attr_name]

			if T.idx !in eaf.acceptable_type_idxs {
				errors << error('Unacceptable type `${T.name}` for attribute function `${unit_name}:${attr_name}` which accepts [${eaf.acceptable_type_names.join(', ')}]')
				continue
			}

			checked_attrs[unit_name][attr_name] = []
		} else {
			errors << error('Unknown attribute function `${unit_name}:${attr_name}`')
			continue
		}
	}

	return Attribute(checked_attrs), errors
}

// Check whether field is tagged with 'vaker:skip'
fn (attr &Attribute) skip() bool {
	return unsafe {
		'skip' in attr['vaker']
	}
}

// Clone and modify DataFaker's field to satisfy field's attribute.
// Returns a modified version of DataFaker, does not modify original one.
fn mod[T](_ &T, attr &Attribute, df &DataFaker) DataFaker {
	mut cm_df := *df

	mut keys := df.attribute_functions.keys()
	keys.sort()

	unsafe {
		match true {
			'str_len' in attr['vaker'] {
				cm_df.str_len = attr['vaker']['str_len'][0].int()
			}
			else {
				for unit_name in attr.keys() {
					for attribute_name in attr[unit_name].keys() {
						if unit_name == 'vaker' {
							func := binary_search(keys, attribute_name) or { panic(err) }
							cm_df.current_attribute_function = &(df.attribute_functions[keys[func]])
						} else {
							func := df.external_attribute_functions[unit_name][attribute_name].function
							cm_df.current_attribute_function = &func
						}
					}
				}
			}
		}
	}
	return cm_df
}

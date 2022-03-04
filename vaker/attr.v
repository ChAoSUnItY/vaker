module vaker

import arrays { binary_search }

type Attribute = map[string][]string

const (
	builtin_attrs = [
		'e164_phone_number',
		'lat',
		'long',
		'phone_number',
		'skip',
		'str_len',
		'toll_free_phone_number',
		'uuid_digit',
		'uuid_hyphenated',
	]
)

// Dummy struct for get_attrs
struct Struct {
}

// get_attrs can effectively collect valid attributes by asserting type symbol T
// For example: attribute `str_len` would eprintln when type symbol T is not `string`
[inline]
fn get_attrs<T>(_ T, fd &FieldData) (Attribute, []IError) {
	attrs := fd.attrs.filter(it.starts_with('vaker')).map(it.trim_string_left('vaker:')).map(it.split_any(':='))
	wrong_type := fn (attribute string, type_name string) IError {
		return error('Attribute `$attribute` could not apply on type $type_name')
	}
	mut errors := []IError{cap: 4}
	mut checked_attrs := map[string][]string{}
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
			errors << error('Unexpected vaker attribute $attribute')
			continue
		}

		match attribute {
			'lat', 'long' {
				$if T !is f32 && T !is f64 {
					errors << wrong_type(attribute, T.name)
					continue
				}
			}
			'phone_number', 'toll_free_phone_number', 'uuid_digit', 'uuid_hyphenated' {
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
					errors << wrong_type('str_len', T.name)
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
			else {
				// Unreachable
			}
		}

		checked_attrs[attribute] = attr[1..]
	}

	return Attribute(checked_attrs), errors
}

// Check whether field is tagged with 'vaker:skip'
fn (attr &Attribute) skip() bool {
	return 'skip' in attr
}

// Clone and modify DataFaker's field to satisfy field's attribute.
// Returns a modified version of DataFaker, does not modify original one.
fn mod<T>(_ &T, attr &Attribute, df &DataFaker) DataFaker {
	mut cm_df := *df

	mut keys := df.attribute_functions.keys()
	keys.sort()

	match true {
		'str_len' in attr {
			cm_df.str_len = (*attr)['str_len'][0].int()
		}
		else {
			for a in attr.keys() {
				func := binary_search(keys, a) or { panic(err) }
				cm_df.current_attribute_function = &(df.attribute_functions[keys[func]])
			}
		}
	}

	return cm_df
}

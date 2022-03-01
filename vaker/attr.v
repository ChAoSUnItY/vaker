module vaker

import arrays { binary_search }

type Attribute = map[string][]string

const (
	builtin_attrs = [
		'skip',
		'str_len',
	]
)

// Dummy struct for get_attrs
struct Struct {
}

// get_attrs can effectively collect valid attributes by asserting type symbol T
// For example: attribute `str_len` would eprintln when type symbol T is not `string`
[inline]
fn get_attrs<T>(_ T, fd &FieldData) Attribute {
	attrs := fd.attrs.filter(it.starts_with('vaker')).map(it.trim_string_left('vaker:')).map(it.split_any(':='))
	mut checked_attrs := map[string][]string{}
	{
		cap:
		1
	}
	for attr in attrs {
		attribute := attr[0] or {
			eprintln('Expect a vaker attribute after `vaker:`')
			continue
		}
		binary_search(vaker.builtin_attrs, attribute) or {
			eprintln('Unexpected vaker attribute $attribute')
			continue
		}

		match attribute {
			'str_len' {
				$if T is string {
					if attr.len != 2 {
						eprintln('Attribute `str_len` requires 1 integer argument')
						continue
					}
				} $else {
					eprintln('Attribute `str_len` could not apply on type $T.name')
					continue
				}
			}
			'skip' {
				if attr.len != 1 {
					eprintln('Unexpected arguments ${attribute[1..]}')
					continue
				}
			}
			else {
				// Unreachable
			}
		}

		checked_attrs[attribute] = attr[1..]
	}

	return Attribute(checked_attrs)
}

// Check whether field is tagged with 'vaker:skip'
fn (attr &Attribute) skip() bool {
	return 'skip' in attr
}

// Modify DataFaker's field to satisfy field's attribute
fn (attr &Attribute) init<T>(_ &T) {
}

fn (attr &Attribute) @defer<T>(_ &T) {
}

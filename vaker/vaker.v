module vaker

import rand

const (
	default_df           = DataFaker{}

	max_string_gen_tries = 100000
)

// Language Boundaries
pub const (
	lb_eng = LangaugeBoundary{65, 122, [rune(91), 92, 93, 94, 95, 96]}
	lb_chi = LangaugeBoundary{19968, 40869, []}
	lb_rus = LangaugeBoundary{1025, 1105, []}
	lb_jpn = LangaugeBoundary{12353, 12534, [rune(12436), 12437, 12438, 12439, 12440, 12441, 12442,
		12443, 12444, 12445, 12446, 12447, 12448]}
	lb_kor = LangaugeBoundary{44032, 55203, []}
	lb_emj = LangaugeBoundary{126976, 129535, []}
)

struct LangaugeBoundary {
	start   int
	end     int
	exclude []rune
}

// Faking data with default options
[inline]
pub fn fake_data<T>(t &T) {
	fake_data_wdf<T>(t, &vaker.default_df)
}

// Faking data with custom options
[inline]
pub fn fake_data_wdf<T>(t &T, df &DataFaker) {
	$if T is $Array {
		unsafe {
			for i in 0 .. t.len {
				fake_data_wdf(&t[i], df)
			}
		}
	} $else $if T is $Map {
		fake_map(t, df)
	}

	if T.typ > 30 {
		$for f in T.fields {
			$if f.typ is string {
			}
			// Dummy expression to generate and specify t.$(f.name)'s type

			mut attrs := get_attrs(t.$(f.name), f)

			if !attrs.skip() {
				fake_data_wdf(&(t.$(f.name)), df)
			}
		}
	} else {
		unsafe {
			*t = fake_primitive_value<T>(df) or { panic(err) }
		}
	}
}

[inline]
fn fake_map<K, V>(m &map[K]V, df &DataFaker) {
	$if K is string {
	}
	// Dummy expression to generate and specify K type
	$if V is string {
	}
	// Dummy expression to generate and specify V type

	fake_entry_count := rand.int_in_range(df.min_map_len, df.max_map_len) or { panic(err) }

	for _ in 0 .. fake_entry_count {
		key := fake_primitive_value<K>(df) or { panic(err) }
		value := fake_primitive_value<V>(df) or { panic(err) }

		unsafe {
			(*m)[key] = value
		}
	}
}

[inline]
fn fake_primitive_value<T>(df &DataFaker) ?T {
	$if T is string {
		return df.primitive_invokers.string_invoker(df)
	} $else $if T is rune {
		return df.primitive_invokers.rune_invoker(df)
	} $else $if T is bool {
		return df.primitive_invokers.bool_invoker(df)
	} $else $if T is i8 {
		return df.primitive_invokers.i8_invoker(df)
	} $else $if T is i16 {
		return df.primitive_invokers.i16_invoker(df)
	} $else $if T is int {
		return df.primitive_invokers.int_invoker(df)
	} $else $if T is i64 {
		return df.primitive_invokers.i64_invoker(df)
	} $else $if T is byte {
		return df.primitive_invokers.byte_invoker(df)
	} $else $if T is u16 {
		return df.primitive_invokers.u16_invoker(df)
	} $else $if T is u32 {
		return df.primitive_invokers.u32_invoker(df)
	} $else $if T is u64 {
		return df.primitive_invokers.u64_invoker(df)
	} $else $if T is f32 {
		return df.primitive_invokers.f32_invoker(df)
	} $else $if T is f64 {
		return df.primitive_invokers.f64_invoker(df)
	} $else {
		return error('type $T.name is not an primitive type')
	}
}

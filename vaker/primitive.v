module vaker

import rand

struct PrimitiveInvokers {
	string_invoker fn (df &DataFaker) string
	rune_invoker fn (df &DataFaker) rune
	bool_invoker fn (df &DataFaker) bool
	i8_invoker fn (df &DataFaker) i8
	i16_invoker fn (df &DataFaker) i16
	int_invoker fn (df &DataFaker) int
	i64_invoker fn (df &DataFaker) i64
	byte_invoker fn (df &DataFaker) byte
	u16_invoker fn (df &DataFaker) u16
	u32_invoker fn (df &DataFaker) u32
	u64_invoker fn (df &DataFaker) u64
	f32_invoker fn (df &DataFaker) f32
	f64_invoker fn (df &DataFaker) f64
}

const (
	primitive_invokers = PrimitiveInvokers {
		string_invoker: fn (df &DataFaker) string {
			mut runes := []rune{cap: df.str_len}

			for i, _ := 0, 0; i < df.str_len; {
				runes << rune(gen<rune>(df))
				i++
			}

			return runes.string()
		}
		rune_invoker: fn (df &DataFaker) rune {
			return gen<rune>(df)
		}
		bool_invoker: fn (df &DataFaker) bool {
			b := gen<i64>(df)
			return b & 1 != 0
		}
		i8_invoker: fn (df &DataFaker) i8 {
			return i8(gen<i64>(df))
		}
		i16_invoker: fn (df &DataFaker) i16 {
			return i16(gen<i64>(df))
		}
		int_invoker: fn (df &DataFaker) int {
			return int(gen<i64>(df))
		}
		i64_invoker: fn (df &DataFaker) i64 {
			return gen<i64>(df)
		}
		byte_invoker: fn (df &DataFaker) byte {
			return byte(gen<u64>(df))
		}
		u16_invoker: fn (df &DataFaker) u16 {
			return u16(gen<u64>(df))
		}
		u32_invoker: fn (df &DataFaker) u32 {
			return u32(gen<u64>(df))
		}
		u64_invoker: fn (df &DataFaker) u64 {
			return gen<u64>(df)
		}
		f32_invoker: fn (df &DataFaker) f32 {
			return f32(gen<f64>(df))
		}
		f64_invoker: fn (df &DataFaker) f64 {
			return gen<f64>(df)
		}
	}
)

fn gen<T>(df &DataFaker) T {
	$if T is i64 {
		return rand.i64_in_range(df.rand_min_sz, df.rand_max_sz) or { panic(err) }
	} $else $if T is u64 {
		return rand.u64_in_range(df.rand_min_usz, df.rand_max_usz) or { panic(err) }
	} $else $if T is f64 {
		return rand.f64_in_range(df.rand_min_fsz, df.rand_max_fsz) or { panic(err) }
	} $else $if T is rune {
		i := rand.int_in_range(df.lb.start, df.lb.end) or { panic(err) }
		return rune(i)
	} $else {
		panic('Unexpected type $T.name')
	}
}

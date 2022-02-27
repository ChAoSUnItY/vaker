module vaker

import rand

const (
	max_string_gen_tries = 100000
)

// Language Boundaries
pub const (
	lb_eng = LangaugeBoundary{65, 122, [rune(91), 92, 93, 94, 95, 96]}
	lb_chi = LangaugeBoundary{19968, 40869, []}
	lb_rus = LangaugeBoundary{1025, 1105, []}
	lb_jpn = LangaugeBoundary{12353, 12534, [rune(12436), 12437, 12438, 12439, 12440, 12441, 12442, 12443, 12444, 12445, 12446, 12447, 12448]}
	lb_kor = LangaugeBoundary{44032, 55203, []}
	lb_emj = LangaugeBoundary{126976, 129535, []}
)

struct LangaugeBoundary {
	start   int
	end     int
	exclude []rune
}

pub struct DataFaker {
	lb &LangaugeBoundary = vaker.lb_eng
}

// Faking data with default values
pub fn fake_data<T>(t &T) {
	$if T is $Array {
		unsafe {
			for i in 0..t.len {
				fake_data(&t[i])
			}
		}
	} $else $if T.typ is string {
		unsafe {
			*t = fake_string(10, &vaker.lb_eng)
		}
	} $else {
		$for f in T.fields {
			$if f.typ is string {} // Dummy expression to force V compiler to generate necessary functions
			
			fake_data(&(t.$(f.name)))
		}
	}
}

// Faking data with default values
pub fn fake_data_wdf<T>(t &T, df &DataFaker) {
	$if T is $Array {
		unsafe {
			for i in 0..t.len {
				fake_data_wdf(&t[i], df)
			}
		}
	} $else $if T.typ is string {
		unsafe {
			*t = fake_string(10, df.lb)
		}
	} $else {
		$for f in T.fields {
			$if f.typ is string {}
			
			fake_data_wdf(&(t.$(f.name)), df)
		}
	}
}

fn fake_string(len int, b &LangaugeBoundary) string {
	mut runes := []rune{cap: len}

	for i, _ := 0, 0; i < len; {
		rand_rune := rune(rand.intn(b.end - b.start) or { println(err) } + b.start)

		runes << rand_rune
		i++
	}

	return runes.string()
}

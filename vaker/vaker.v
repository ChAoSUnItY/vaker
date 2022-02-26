module vaker

import rand

struct LangaugeBoundary {
	start int
	end int
	exclude []rune
}

const (
	max_string_gen_tries = 100000
)

// Language Boundaries
const (
	lb_EN = LangaugeBoundary {65, 122, [rune(91), 92, 93, 94, 95, 96]}
)

pub fn fake_data<T>(structure &T) {
	$for f in T.fields {
		$if f.typ is string {
			(*structure).$(f.name) = fake_string(10, &lb_EN)
		}
	}
}

fn fake_string(len int, b &LangaugeBoundary) string {
	mut runes := []rune{cap: len}

	for i, counter := 0, 0; i < len; {
		rand_rune := rune(rand.intn(b.end - b.start) + b.start)

		runes << rand_rune
		i++
	}

	return runes.string()
}

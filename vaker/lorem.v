module vaker

import rand
import strings

const words = [
	'alias',
	'consequatur',
	'aut',
	'perferendis',
	'sit',
	'voluptatem',
	'accusantium',
	'doloremque',
	'aperiam',
	'eaque',
	'ipsa',
	'quae',
	'ab',
	'illo',
	'inventore',
	'veritatis',
	'et',
	'quasi',
	'architecto',
	'beatae',
	'vitae',
	'dicta',
	'sunt',
	'explicabo',
	'aspernatur',
	'aut',
	'odit',
	'aut',
	'fugit',
	'sed',
	'quia',
	'consequuntur',
	'magni',
	'dolores',
	'eos',
	'qui',
	'ratione',
	'voluptatem',
	'sequi',
	'nesciunt',
	'neque',
	'dolorem',
	'ipsum',
	'quia',
	'dolor',
	'sit',
	'amet',
	'consectetur',
	'adipisci',
	'velit',
	'sed',
	'quia',
	'non',
	'numquam',
	'eius',
	'modi',
	'tempora',
	'incidunt',
	'ut',
	'labore',
	'et',
	'dolore',
	'magnam',
	'aliquam',
	'quaerat',
	'voluptatem',
	'ut',
	'enim',
	'ad',
	'minima',
	'veniam',
	'quis',
	'nostrum',
	'exercitationem',
	'ullam',
	'corporis',
	'nemo',
	'enim',
	'ipsam',
	'voluptatem',
	'quia',
	'voluptas',
	'sit',
	'suscipit',
	'laboriosam',
	'nisi',
	'ut',
	'aliquid',
	'ex',
	'ea',
	'commodi',
	'consequatur',
	'quis',
	'autem',
	'vel',
	'eum',
	'iure',
	'reprehenderit',
	'qui',
	'in',
	'ea',
	'voluptate',
	'velit',
	'esse',
	'quam',
	'nihil',
	'molestiae',
	'et',
	'iusto',
	'odio',
	'dignissimos',
	'ducimus',
	'qui',
	'blanditiis',
	'praesentium',
	'laudantium',
	'totam',
	'rem',
	'voluptatum',
	'deleniti',
	'atque',
	'corrupti',
	'quos',
	'dolores',
	'et',
	'quas',
	'molestias',
	'excepturi',
	'sint',
	'occaecati',
	'cupiditate',
	'non',
	'provident',
	'sed',
	'ut',
	'perspiciatis',
	'unde',
	'omnis',
	'iste',
	'natus',
	'error',
	'similique',
	'sunt',
	'in',
	'culpa',
	'qui',
	'officia',
	'deserunt',
	'mollitia',
	'animi',
	'id',
	'est',
	'laborum',
	'et',
	'dolorum',
	'fuga',
	'et',
	'harum',
	'quidem',
	'rerum',
	'facilis',
	'est',
	'et',
	'expedita',
	'distinctio',
	'nam',
	'libero',
	'tempore',
	'cum',
	'soluta',
	'nobis',
	'est',
	'eligendi',
	'optio',
	'cumque',
	'nihil',
	'impedit',
	'quo',
	'porro',
	'quisquam',
	'est',
	'qui',
	'minus',
	'id',
	'quod',
	'maxime',
	'placeat',
	'facere',
	'possimus',
	'omnis',
	'voluptas',
	'assumenda',
	'est',
	'omnis',
	'dolor',
	'repellendus',
	'temporibus',
	'autem',
	'quibusdam',
	'et',
	'aut',
	'consequatur',
	'vel',
	'illum',
	'qui',
	'dolorem',
	'eum',
	'fugiat',
	'quo',
	'voluptas',
	'nulla',
	'pariatur',
	'at',
	'vero',
	'eos',
	'et',
	'accusamus',
	'officiis',
	'debitis',
	'aut',
	'rerum',
	'necessitatibus',
	'saepe',
	'eveniet',
	'ut',
	'et',
	'voluptates',
	'repudiandae',
	'sint',
	'et',
	'molestiae',
	'non',
	'recusandae',
	'itaque',
	'earum',
	'rerum',
	'hic',
	'tenetur',
	'a',
	'sapiente',
	'delectus',
	'ut',
	'aut',
	'reiciendis',
	'voluptatibus',
	'maiores',
	'doloribus',
	'asperiores',
	'repellat',
]

fn random_sentence() string {
	len := rand.int_in_range(1, 7) or { 2 }
	mut b := strings.new_builder(16)
	for i in 0 .. len {
		if i == 0 {
			b.write_string(rand_element(vaker.words).title())
		} else {
			b.write_string(rand_element(vaker.words))
		}

		if i != len - 1 {
			b.write_string(' ')
		}
	}
	return b.str()
}

[inline]
pub fn word(ptr PtrInfo) {
	unsafe {
		cast_assign(ptr, rand_element(vaker.words))
	}
}

[inline]
pub fn sentence(ptr PtrInfo) {
	unsafe {
		cast_assign(ptr, random_sentence())
	}
}

[inline]
pub fn paragraph(ptr PtrInfo) {
	len := rand.intn(11) or { 1 } + 1
	mut b := strings.new_builder(16)
	for i in 0 .. len {
		b.write_string(random_sentence())
		b.write_string('.')

		if i != len - 1 {
			b.write_string(' ')
		}
	}
	unsafe {
		cast_assign(ptr, b.str())
	}
}
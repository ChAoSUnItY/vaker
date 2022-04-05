module vaker

struct CreditCard {
	cc_type  string
	length   int
	prefixes []int
}

const credit_cards = {
	'visa':             CreditCard{'VISA', 16, [51, 52, 53, 54, 55]}
	'mastercard':       CreditCard{'MasterCard', 16, [51, 52, 53, 53, 55]}
	'american express': CreditCard{'American Express', 15, [34, 37]}
	'discover':         CreditCard{'Discover', 16, [6011]}
	'jcb':              CreditCard{'JCB', 16, [3528, 3538, 3548, 3558, 3568, 3578, 3588]}
	'diners club':      CreditCard{'Diners Club', 14, [36, 38, 39]}
}

const cc_types = [
	'visa',
	'mastercard',
	'american express',
	'discover',
	'jcb',
	'diners club',
]

[inline]
fn cc_typ() string {
	return vaker.credit_cards[rand_element(vaker.cc_types)].cc_type
}

[inline]
pub fn cc_type(ptr PtrInfo) {
	unsafe {
		cast_assign(ptr, cc_typ())
	}
}

[inline]
pub fn cc_number(ptr PtrInfo) {
	cc_type := cc_typ()
	card := vaker.credit_cards[cc_type.to_lower()]
	prefix := rand_element(card.prefixes)

	unsafe {
		cast_assign(ptr, '$prefix${rand_digit_string(card.length - prefix.str().len)}')
	}
}

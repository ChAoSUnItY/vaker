module vaker

import rand
import arrays

const (
	tld         = ['com', 'biz', 'info', 'net', 'org', 'ru']
	url_formats = ['http://www.%s/', 'https://www.%s/', 'http://%s/', 'https://%s/',
		'http://www.%s/%s', 'https://www.%s/%s', 'http://%s/%s', 'https://%s/%s', 'http://%s/%s.html',
		'https://%s/%s.html', 'http://%s/%s.php', 'https://%s/%s.php']
)

[inline]
pub fn email(ptr PtrInfo) {
	email_name := rand_string(7, &lb_eng)
	email_domain := rand_string(7, &lb_eng)
	email_tld := vaker.tld[rand.intn(vaker.tld.len) or { 0 }]
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '$email_name@${email_domain}.$email_tld'
	}
}

[inline]
pub fn mac_address(ptr PtrInfo) {
	random_hex := rand.hex(12)
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '${random_hex[..2]}:${random_hex[2..4]}:${random_hex[4..6]}:${random_hex[6..8]}:${random_hex[8..10]}:${random_hex[10..]}'
	}
}

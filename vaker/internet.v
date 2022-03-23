module vaker

import rand
import strconv

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
	email_tld := rand_element(vaker.tld)
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '$email_name@${email_domain}.$email_tld'
	}
}

[inline]
pub fn mac_address(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = insert_sep(rand.hex(12), ':', 2)
	}
}

[inline]
pub fn domain_name(ptr PtrInfo) {
	domain_tld := rand_element(vaker.tld)
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '${rand_string(7, &lb_eng)}.$domain_tld'
	}
}

[inline]
pub fn url(ptr PtrInfo) {
	format := rand_element(vaker.url_formats)
	count := format.count('%s')
	domain_tld := rand_element(vaker.tld)
	domain_name := '${rand_string(7, &lb_eng)}.$domain_tld'
	pointer := &string(ptr.ptr)

	if count == 1 {
		unsafe {
			*pointer = strconv.v_sprintf(format, domain_name)
		}
	} else {
		user_name := rand_string(7, &lb_eng)

		unsafe {
			*pointer = strconv.v_sprintf(format, domain_name, user_name)
		}
	}
}

[inline]
pub fn user_name(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = rand_string(7, &lb_eng)
	}
}

[inline]
pub fn ipv4(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = insert_sep(rand_digit_string(8), '.', 2)
	}
}

[inline]
pub fn ipv6(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = insert_sep(rand.hex(32), ':', 4)
	}
}

[inline]
pub fn password(ptr PtrInfo) {
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = rand_string(50, &lb_eng)
	}
}

[inline]
pub fn jwt(ptr PtrInfo) {
	element := rand_string(40, &lb_eng)
	pointer := &string(ptr.ptr)
	unsafe {
		*pointer = '${element}.${element}.$element'
	}
}

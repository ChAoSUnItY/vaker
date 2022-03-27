module main

import vaker
import time

struct St {
	latitude               f32    ['vaker:lat']
	longitude              f32    ['vaker:long']
	credit_card_number     string ['vaker:cc_number']
	credit_card_type       string ['vaker:cc_type']
	email                  string ['vaker:email']
	domain_name            string ['vaker:domain_name']
	ipv4                   string ['vaker:ipv4']
	ipv6                   string ['vaker:ipv6']
	password               string ['vaker:password']
	jwt                    string ['vaker:jwt']
	phone_number           string ['vaker:phone_number']
	mac_address            string ['vaker:mac_address']
	url                    string ['vaker:url']
	user_name              string ['vaker:user_name']
	toll_free_phone_number string ['vaker:toll_free_phone_number']
	e164phone_number       string ['vaker:e164_phone_number']
	title_male             string ['vaker:title_male']
	title_female           string ['vaker:title_female']
	first_name             string ['vaker:first_name']
	first_name_male        string ['vaker:first_name_male']
	first_name_female      string ['vaker:first_name_female']
	last_name              string ['vaker:last_name']
	name                   string ['vaker:name']
	unix_time              i64    ['vaker:unix_time']
	date                   string ['vaker:date']
	time                   string ['vaker:time']
	month                  string ['vaker:month']
	year                   string ['vaker:year']
	day_of_week            string ['vaker:day_of_week']
	timestamp              string ['vaker:timestamp']
	century                string ['vaker:century']
	time_zone              string ['vaker:timezone']
	period                 string ['vaker:period']
	word                   string ['vaker:word']
	sentence               string ['vaker:sentence']
	paragraph              string ['vaker:paragraph']
	currency               string ['vaker:currency']
	amount                 f64    ['vaker:amount']
	amount_with_currency   string ['vaker:amount_with_currency']
	uuid_hypenated         string ['vaker:uuid_hyphenated']
	uuid                   string ['vaker:uuid_digit']
	skip                   string ['vaker:skip']
	str_len5               string ['vaker:str_len=5'] // Default len is set to 10
}

fn main() {
	st := St{}
	vaker.fake_data(&st)
	println(st)
}

// St{
//     latitude: 235.8904
//     longitude: -118.9505
//     credit_card_number: '6011854711796225'
//     credit_card_type: 'JCB'
//     email: 'FaAxiad@URuRxMv.ru'
//     domain_name: 'khqxRYv.org'
//     ipv4: '23.82.36.98'
//     ipv6: '3de3:7747:6609:6769:1399:a313:08da:9223'
//     password: 'DjHuDLioRoAPTEuQDiYSlgcMNfuWVIZdnxEiQtTyilxEgermMe'
//     jwt: 'BDsQeOATfFbjUBZGvTSgCQIHfyZkuMGNYhZKtbEq.BDsQeOATfFbjUBZGvTSgCQIHfyZkuMGNYhZKtbEq.BDsQeOATfFbjUBZGvTSgCQIHfyZkuMGNYhZKtbEq'
//     phone_number: '534-622-4186'
//     mac_address: '9f:6e:f9:7f:c0:2d'
//     url: 'http://kjUVQod.biz/aLUYZrc.html'
//     user_name: 'RttlAMo'
//     toll_free_phone_number: '(777) 239-658600'
//     e164phone_number: '+8373926674'
//     title_male: 'Dr.'
//     title_female: 'King'
//     first_name: 'Malvina'
//     first_name_male: 'Afton'
//     first_name_female: 'Yazmin'
//     last_name: 'Powlowski'
//     name: 'Lady Ericka Vandervort'
//     unix_time: 6458965484626575704
//     date: '2004-04-27'
//     time: '01:02:53'
//     month: 'Mar'
//     year: '1991'
//     day_of_week: 'Friday'
//     timestamp: '2007-02-27 11:27:07'
//     century: 'XIII'
//     time_zone: 'Africa/Lagos'
//     period: 'PM'
//     word: 'temporibus'
//     sentence: 'Corporis'
//     paragraph: 'Dignissimos quae ipsa. Accusantium fuga. Eligendi voluptatem a enim illum. Et quis. Soluta libero officia aut non rerum.'
//     currency: 'BMD'
//     amount: 77758.85
//     amount_with_currency: '47863.59 XPT'
//     uuid_hypenated: '838bd7e3-a3f3-4183-8a18-9bfa6bb7dd0d'
//     uuid: 'a1b4dc9f0a6b4008a4eeeef47e30e6a0'
//     skip: ''
//	   str_len5: 'Vck^K'
// }

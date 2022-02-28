module vaker

pub struct DataFaker {
mut:
	lb      &LangaugeBoundary = &vaker.lb_eng
	str_len int = 10
	max_arr_len int = 10
	min_arr_len int
	max_map_len int = 10
	min_map_len int
	rand_max_sz i64 = 100
	rand_min_sz i64
	rand_max_usz u64 = 100
	rand_min_usz u64
	rand_max_fsz f64 = 100
	rand_min_fsz f64
	primitive_invokers PrimitiveInvokers = primitive_invokers
}

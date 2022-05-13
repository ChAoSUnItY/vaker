# vaker
> Light-weight data faker built in V to generate massive amounts of fake (but realistic) data for testing and development.

[![Vaker-doc - Document](https://img.shields.io/badge/_Vaker--doc-Document-2ea44f?logo=V)](https://chaosunity.github.io/Vaker-doc/)

## Usage

### Basic
```v
import vaker

fn main() {
    a := []string{len:10}
    vaker.fake_data(&a)
}
```

### Credit Card
```v
import vaker

// Don't add [required] so you don't have to assign all values at start
struct MemberInfo {
	member_name        string ['vaker:name']
	credit_card_type   string ['vaker:cc_type']
	credit_card_number string ['vaker:cc_number']
}

fn main() {
	a := MemberInfo{}
	vaker.fake_data(&a)
}
```

### Geo-related data
```v
import vaker

struct GeoData {
	location  Location
	email	  string   ['vaker:email']
	user_name string   ['vaker:user_name']
}

struct Location {
	longtitude string ['vaker:long']
	latitude   string ['vaker:lat']
}

fn main() {
	a := GeoData{}
	vaker.fake_data(&a)
}
```

### Custom faking functions
> You can find the custom faking function example in [example_custom_attribute.v](/example_custom_attribute.v)
To add custom faking functions:

1. Clone a DataFaker
```v
mut df := vaker.new_df()
```

2. register a unit (or domain)
```v
df.register('your unit')
```

3. create a faking function, faking function must be `fn (vaker.PtrInfo)`, you'll need to provide a type parameter to specify which type your faking function at least support
```v
df.register_fn<TypeHere>('your domain', 'your faking function's name', faking_function_ptr) ?
```

4. (Optional) to support more types to be accepted by your faking function, call `vaker.DataFaker#add_type<T>(string, string)`
```v
// add support for string type
df.add_type<string>('your unit', 'your faking function's name') ?
```

## Supported Data Types

Vaker supports:  
`[]T`, `T[]! (Sized array)`, `map[K]V`, `string`, `rune`, `bool`, `i8`, `i16`,  
`int`, `i64`, `byte`, `u16`, `u32`, `u64`, `f32`, `f64`, `struct`, `time.Time`

**while:**
***every type symbols: T, K, V, isn't interface***

Additionally, Vaker supports embedded structure, or nested struct data faking.

Vaker does not support faking:
`interface`

See [Limitations](#limitations)

## Supported Attributes

See [example.v](./example.v) for full attribute list and their effects.

## Spec

Vaker uses compile time reflection to minimize runtime memory overhead as much as possible.

### Bench

```v
import vaker

struct St {
	Bs
	a string ['vaker:str_len=10']
}

struct Bs {
	Fs
	a string ['vaker:skip']
}

struct Fs {
	a map[int]string
}

fn main() {
	a := map[int]string{}
	st := St{}
	b := []int{len: 6}
	vaker.fake_data(&a)
	vaker.fake_data(&st)
	vaker.fake_data(&b)
}
```

```cmd
> v run ./main.v

================
CPU     136%
user    0.258
system  0.038
total   0.217
```

```cmd
> v -prod ./main.v

================
CPU     101%
user    4.062
system  0.136
total   4.121
     
> ./main

================
CPU     82%
user    0.001
system  0.000
total   0.002
```

### Explaination

Vaker generates faking functions at compile time, so it spend more memory/time on compilation, but this doesn't effect actual runtime performance.

## Limitations

1. Vaker does not support faking interface, since interface in V cannot be implemented in runtime.

## Contribution

You can open a PR or an issue.

## Maintainers

ChAoS-UnItY

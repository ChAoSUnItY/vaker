# vaker
A light-weight data faker written in V Lang.

[![ Vaker-doc - Document](https://img.shields.io/badge/_Vaker--doc-Document-2ea44f?logo=V)](https://chaosunity.github.io/Vaker-doc/)

## Usage

```v
import vaker

fn main() {
    a := []string{len:10}
    vaker.fake_data(&a)
}
```

## Supported Data Types

Vaker supports:  
`[]T`, `map[K]V`, `string`, `rune`, `bool`, `i8`, `i16`,  
`int`, `i64`, `byte`, `u16`, `u32`, `u64`, `f32`, `f64`, `struct`

**while:**
***every type symbols: T, K, V, isn't interface or sized array (Unstable for now)***

Additionally, Vaker supports embedded structure, or nested struct data faking.

Vaker does not support faking:
`interface`, `T[]! (Sized array)`

See [Limitations](#limitations)

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
2. Vaker does not support faking sized array, since V's compile-time reflection cannot assume whether array is sized or not, which leads not unknown size of array <br/> <b> Update: It's confirmed that this limitation is not really a **limitation** but a  *V Lang compiler bug*, I will keep tracking this until the bug is fixed, see https://github.com/vlang/v/issues/13632 </b>

## Contribution

You can open a PR or an issue.

## Maintainers

ChAoS-UnItY

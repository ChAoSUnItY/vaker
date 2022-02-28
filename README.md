# vaker
A light-weight data faker written in V Lang

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
***every type symbols: T, K, V, isn't interface or sized array***

Additionally, Vaker supports embedded structure, or nested struct data faking.

Vaker does not support faking:
`interface`, `T[]! (Sized array)`

See [Limitations](#limitations)

## Spec

Vaker uses compile time reflection to minimize runtime memory overhead as much as possible.

## Limitations

1. Vaker does not support faking interface, since interface in V cannot be implemented in runtime.
2. Vaker does not support faking sized array, since V's compile-time reflection cannot assume whether array is sized or not, which leads not unknown size of array 

## Contribution

You can open a PR or an issue.

## Maintainers

ChAoS-UnItY

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

## Spec

Vaker uses compile time reflection to minimize runtime memory overhead as much as possible.

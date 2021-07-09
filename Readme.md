# Quil-QIR

Translate between [Quil](https://github.com/quil-lang/quil) and [QIR](https://devblogs.microsoft.com/qsharp/introducing-quantum-intermediate-representation-qir/).

# Building

## Requirements

- [rust](https://rustup.rs/)
- [LLVM 11](https://releases.llvm.org/11.0.0/docs/ReleaseNotes.html)

## Build type

We support two build modes:

- `--bin` produces an executable standalone binary
- `--lib` produces a shared library that can be imported by python

### Standalone

1. Build `quil-qir` with `cargo build --bin quil-qir`
2. (a) Run with `cargo run --bin quil-qir-- translate <path/to/llvm.bc>`, or (b) run with `./target/debug/quil-qir translate <path/to/llvm.bc>`if you have previously built (as in 1.)

### Shared library

Building a shared library is slightly more complicated. To simplify things we will later use [`maturin`](https://github.com/PyO3/maturin). For now, we will do things the long way.

#### macOS

1. Build the shared library

```
cargo rustc --lib --release -- -C link-arg=-undefined -C link-arg=dynamic_lookup
```

2. Rename to use the `.so` extension

```
cp target/release/libquil_qir.dylib quil_qir.so
```

3. Import and use in python

```
import quil_qir
quil_qir.to_quil("data/BellState.bc")
```

#### Windows

1. Build the shared library

```
cargo rustc --lib --release
```

2. Rename to use the `.pyd` extension

```
cp target/release/libquil_qir.dll quil_qir.pyd
```

3. Import and use in python

```
import quil_qir
quil_qir.to_quil("data/BellState.bc")
```

#### `maturin`

`maturin` reduces some of the overhead and will be particularly useful when we want to publish the python bindings. For now, it will take care of building the python bindings and moving them into the correct location such that we can import them

1. Create a virtualenv: `python3 -m venv env && source env/bin/activate`
2. Install `maturin`: `pip install maturin`
3. Build and install the crate as a python module in the current environment: `maturin develop`
4. Import and use in python as above

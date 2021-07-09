.PHONY: configure-ssh initialize samples test test-python

test:
	RUST_BACKTRACE=full cargo test -- --nocapture

test-python:
	poetry install
	poetry run maturin develop
	poetry run python test/rust.py

# Once your vagrant box is configured, this will set it up so you can ssh into it with plain `ssh` and `scp`
# instead of having to use `vagrant ssh`
configure-ssh:
	cd vagrant && vagrant ssh-config >> ~/.ssh/config

# Run this to get your vagrant box set up and ready for compilation.
# Note, you'll need to install virtualbox first.
initialize:
	cd vagrant && vagrant up
	make configure-ssh
	cd vagrant && ssh default 'choco install git && git clone https://github.com/microsoft/qsharp-compiler'

samples:
	./scripts/build-samples.sh

macos-python-library:
	cargo rustc --lib --release -- -C link-arg=-undefined -C link-arg=dynamic_lookup
	cp ./target/release/libquil_qir.dylib ./target/release/quil_qir.so

windows-python-library:
	cargo rustc --lib --release
	cp ./target/release/libquil_qir.dll ./target/release/quil_qir.pyd
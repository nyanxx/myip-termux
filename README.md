# myip-termux

Termux native cli-tool that shows ip address ( swlan0 interface )

## Usage

```shell
myip
```

Returns the `IP` or `null` if not found.

## Install & Run

-  You can either **build** the project binary yourself.
-  Download the pre-compiled **binary** manually from release or with the `install.sh` script.

### Build

You can build your own binary on termux for that you need to install Rust 🦀

```shell
pkg install rust
```

Verify the toolchain ( look for `aarch64` )
 
```shell
rushc -Vv
```

Clone Repository

```shell
git clone https://github.com/nyanxx/myip-termux.git
cd myip-termux
```

Build binary

```bash
cargo build --release
```

Grant permission and execute

```bash
chmod +x ./target/release/myip
# Optional: move to `/usr/bin`
mv ./target/release/myip $PREFIX/bin/
```

### Install Script

```bash
curl -sL https://raw.githubusercontent.com/nyanxx/myip-termux/main/install.sh | bash
```


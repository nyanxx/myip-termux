#!/usr/bin/env bash

set -e
trap 'echo "❌ An error occurred. Exiting..."; rm -rf "$TMPDIR"; exit 1' ERR

REPO="nyanxx/myip-termux"
TAG="v0.1.0"
BIN="myip"
ARCH=$(uname -m)
PREFIX_BIN="$PREFIX/bin"
TMPDIR=$(mktemp -d)

# Validate Termux
if [ -z "$PREFIX" ] || [ ! -d "$PREFIX_BIN" ]; then
	echo "❌ This installer is intended for Termux only."
	exit 1
fi

# Check if required tools are available
for cmd in curl tar; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "❌ '$cmd' is not installed. Please install it and retry."
		exit 1
	fi
done

# Map uname to expected arch tag
case "$ARCH" in
	aarch64)
		TARGET_ARCH="aarch64"
		;;
	armv7l)
		TARGET_ARCH="armv7"
		;;
	*)
		echo "❌ Unsupported architecture: $ARCH"
		exit 1
		;;
esac

echo "📦 Downloading $BIN $TAG for $TARGET_ARCH..."
URL="https://github.com/$REPO/releases/download/$TAG/${TAG}.tar.gz"
curl -fsSL "$URL" -o "$TMPDIR/$BIN.tar.gz"
#file "$TMPDIR/$BIN.tar.gz"

echo "📂 Extracting..."
tar -xzf "$TMPDIR/$BIN.tar.gz" -C "$TMPDIR"

if [ -f "$PREFIX_BIN/$BIN" ]; then
	echo "⚠️ File already exists at $PREFIX_BIN/$BIN"
	read -p "Do you want to overwrite it? [y/N] " -r
	if [[ ! $REPLY =~ ^[Yy]$ ]]; then
		echo "❌ Installation cancelled."
		rm -rf "$TMPDIR"
		exit 1
	fi
	rm "$PREFIX_BIN/$BIN"
fi

echo "🚚 Installing to $PREFIX_BIN..."
mv "$TMPDIR/$BIN" "$PREFIX_BIN/"
chmod +x "$PREFIX_BIN/$BIN"

echo "✅ Installed successfully!"
echo "Try: $BIN"	
#"$BIN" --version

# Clean up
rm -rf "$TMPDIR"
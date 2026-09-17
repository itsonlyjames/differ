#!/bin/bash
# Builds Differ.app: compiles the Swift package and assembles a standard
# macOS .app bundle (no server, no browser install flow — just a native app).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$ROOT/app"
DIST="$ROOT/Differ.app"

echo "Building Swift package (release)..."
cd "$APP_DIR"
swift build -c release

BIN_PATH="$(swift build -c release --show-bin-path)"

echo "Assembling Differ.app..."
rm -rf "$DIST"
mkdir -p "$DIST/Contents/MacOS" "$DIST/Contents/Resources"

cp "$BIN_PATH/Differ" "$DIST/Contents/MacOS/Differ"
cp "$APP_DIR/Info.plist" "$DIST/Contents/Info.plist"
cp "$ROOT/icons/AppIcon.icns" "$DIST/Contents/Resources/AppIcon.icns"

# Copy the SwiftPM resource bundle (contains index.html) alongside the binary,
# matching where Bundle.module expects to find it at runtime.
RESOURCE_BUNDLE=$(find "$BIN_PATH" -maxdepth 1 -name "*.bundle" | head -n1)
if [ -n "$RESOURCE_BUNDLE" ]; then
  cp -R "$RESOURCE_BUNDLE" "$DIST/Contents/Resources/"
fi

xattr -cr "$DIST"

echo "Built: $DIST"
echo "Run:   open \"$DIST\""

#!/usr/bin/env bash
# Release build for Play Store upload.
# Outputs: build/app/outputs/bundle/release/app-release.aab
# Symbols (for Crashlytics):  build/symbols/

set -euo pipefail

cd "$(dirname "$0")/.."

echo "==> Cleaning previous build"
flutter clean
flutter pub get

echo "==> Generating localization"
flutter gen-l10n || true

echo "==> Building release AAB"
flutter build appbundle \
  --release \
  --tree-shake-icons \
  --obfuscate \
  --split-debug-info=build/symbols

echo ""
echo "✅ AAB ready:"
echo "   build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "📁 Debug symbols saved to: build/symbols/"
echo "   (Upload to Firebase Crashlytics after release)"
echo ""
echo "Upload AAB to Play Console → Production → Create new release"

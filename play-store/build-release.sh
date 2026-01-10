#!/bin/bash

# TapKit Release Build Script
# This script builds the Android App Bundle (AAB) for Play Store publishing

set -e  # Exit on error

echo "🔨 Building TapKit for Google Play Store..."
echo ""

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build Android App Bundle
echo "🚀 Building Android App Bundle (AAB)..."
flutter build appbundle --release

echo ""
echo "✅ Build completed successfully!"
echo ""
echo "📍 AAB location: build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "📋 Next steps:"
echo "   1. Upload the AAB to Google Play Console"
echo "   2. Complete store listing (see STORE_LISTING.md)"
echo "   3. Add release notes (see RELEASE_NOTES.md)"
echo "   4. Complete data safety form (see DATA_SAFETY_FORM.md)"
echo "   5. Upload required assets (see ASSETS_REQUIREMENTS.md)"
echo ""
echo "📚 See play-store/PUBLISHING_CHECKLIST.md for complete publishing guide"
echo ""


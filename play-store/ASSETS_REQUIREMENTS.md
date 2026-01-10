# Google Play Console Assets Requirements

## Required Graphics Assets

### 1. App Icon
- **Status**: ✅ Available
- **Location**: `android/app/src/main/res/mipmap-*/ic_launcher.png`
- **Requirements**:
  - Format: PNG (32-bit with alpha channel)
  - Size: 512 x 512 pixels
  - Background: Can be transparent or solid color
  - Must not have rounded corners (Play Store will add them)
  - No text, icons only

### 2. Feature Graphic
- **Status**: ❌ **NEEDS TO BE CREATED**
- **Requirements**:
  - Format: JPG or PNG (24-bit)
  - Size: 1024 x 500 pixels
  - No transparency
  - This is the promotional banner shown at the top of your Play Store listing
  - Should include: App name, key features, branding
  - **Action Required**: Create a feature graphic before publishing

### 3. Phone Screenshots (Required)
- **Status**: ❌ **NEEDS TO BE CREATED**
- **Minimum**: 2 screenshots
- **Recommended**: 4-8 screenshots
- **Requirements**:
  - Format: JPG or PNG (24-bit)
  - Size: 16:9 or 9:16 aspect ratio
  - Minimum resolution: 320px
  - Maximum resolution: 3840px
  - Suggested sizes: 1080 x 1920 (portrait) or 1920 x 1080 (landscape)
  - Should showcase: Calculator, Notes, QR Scanner, Dark Mode

### 4. Tablet Screenshots (Optional but Recommended)
- **Status**: ❌ **NEEDS TO BE CREATED**
- **Requirements**:
  - Format: JPG or PNG (24-bit)
  - 7-inch tablet: 1024 x 600 (landscape) or 600 x 1024 (portrait)
  - 10-inch tablet: 1280 x 800 (landscape) or 800 x 1280 (portrait)

### 5. TV Screenshots (Not Required - Skip)
- Not applicable for this app

## Screenshot Recommendations

### Suggested Screenshot Sequence:
1. **Home Screen** - Show the main navigation and app overview
2. **Calculator** - Show calculator interface with a calculation
3. **Calculator History** - Display calculation history
4. **Notes List** - Show notes interface with multiple notes
5. **Note Editor** - Display note creation/editing screen
6. **QR Scanner** - Show QR scanning interface (optional, requires camera)
7. **Settings** - Display settings screen with dark mode option
8. **Dark Mode** - Show app in dark mode

### Screenshot Best Practices:
- Use real device screenshots, not emulator (unless necessary)
- Ensure screenshots show actual app content, not placeholders
- Add text overlays highlighting key features (optional but effective)
- Keep text minimal and readable
- Maintain consistent design style across all screenshots

## Privacy Policy
- **Status**: ✅ Available
- **Location**: `PRIVACY_POLICY.md`
- **Requirements**:
  - Must be hosted on a publicly accessible URL
  - Format: Web page or PDF
  - Must include: Company name, contact information, data collection practices
  - **Action Required**: Host `PRIVACY_POLICY.md` on a web server and provide URL in Play Console

## App Bundle/AAB (Recommended)
- **Status**: ⚠️ Currently have APK
- **Current**: `app-release.apk` exists
- **Recommended**: Build Android App Bundle (AAB) instead of APK
  - Smaller download size for users
  - Dynamic delivery optimization
  - Better compression
- **Action Required**: Build AAB using:
  ```bash
  flutter build appbundle --release
  ```

## App Signing
- **Status**: ✅ Configured
- **Location**: `android/app/key.jks` and `android/key.properties`
- **Note**: Ensure keystore is securely backed up before publishing


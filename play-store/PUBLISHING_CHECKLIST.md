# Google Play Console Publishing Checklist

## Pre-Publication Checklist

### ✅ App Information
- [x] App name: TapKit
- [x] Package name: com.tapkit.app
- [x] Version: 1.0.0
- [x] Version code: 1
- [x] App icon: Available (needs verification)
- [ ] Feature graphic: **REQUIRED - NEEDS CREATION**
- [ ] Privacy policy URL: **REQUIRED - NEEDS HOSTING**

### ✅ Store Listing
- [x] Short description (80 chars): "Calculator, Notes & QR Scanner — all in one convenient app"
- [x] Full description: Created (see STORE_LISTING.md)
- [x] Category: Productivity / Tools
- [ ] Screenshots (minimum 2): **REQUIRED - NEEDS CREATION**
- [ ] Feature graphic: **REQUIRED - NEEDS CREATION**

### ✅ App Content
- [x] Target audience: Everyone (All ages)
- [x] Content rating questionnaire: Needs to be completed in Play Console
- [x] Sensitive permissions declaration: Camera (optional, QR scanner only)
- [ ] Data safety section: **REQUIRED - Needs completion in Play Console**

### ✅ App Release
- [x] Release notes: Created (see RELEASE_NOTES.md)
- [ ] App bundle (AAB): **RECOMMENDED - Build AAB instead of APK**
  - Command: `flutter build appbundle --release`
  - Output: `build/app/outputs/bundle/release/app-release.aab`
- [ ] Signing: Configured (verify keystore is backed up)

### ✅ Privacy & Compliance
- [x] Privacy policy: Written (PRIVACY_POLICY.md)
- [ ] Privacy policy URL: **REQUIRED - Host and provide URL**
- [x] Data collection declaration: No data collected
- [ ] GDPR compliance: Yes (documented in privacy policy)
- [ ] COPPA compliance: Yes (no data collection from children)

### ✅ Testing & Quality
- [ ] Internal testing: Upload to internal test track first
- [ ] Closed testing: Test with beta testers (optional but recommended)
- [ ] Device compatibility: Test on multiple Android versions (5.0+)
- [ ] Performance testing: Verify app performance and battery usage
- [ ] Permissions testing: Test camera permission flow for QR scanner

## Step-by-Step Publishing Guide

### 1. Create Google Play Console Account
- Sign up at https://play.google.com/console
- Pay one-time registration fee ($25)
- Complete account verification

### 2. Create New App
- Click "Create app"
- Fill in app details:
  - App name: TapKit
  - Default language: English (United States)
  - App or game: App
  - Free or paid: Free
  - Declarations: Check all applicable boxes

### 3. Complete Store Listing
- Go to "Store presence" > "Main store listing"
- Upload feature graphic (1024 x 500px)
- Upload at least 2 phone screenshots
- Fill in short and full descriptions (use STORE_LISTING.md)
- Select categories: Productivity (primary), Tools (secondary)
- Add contact details:
  - Email: opalwishopc1997@gmail.com
  - Website: (if available)

### 4. Set Up App Content
- Complete "Content rating" questionnaire
  - Select: Productivity, Tools
  - No user-generated content: Yes
  - No social features: Yes
  - No violence, etc.: Yes
  - Result should be: Everyone
- Complete "Data safety" section:
  - Does your app collect data? No
  - Does your app share data? No
  - Camera permission: Optional, only for QR scanning

### 5. Prepare App Release

#### Build Android App Bundle (Recommended)
```bash
cd /root/Desktop/TapKit
flutter clean
flutter pub get
flutter build appbundle --release
```

The AAB will be at: `build/app/outputs/bundle/release/app-release.aab`

#### Verify Release Bundle
- Check app size
- Verify signing configuration
- Ensure version code is correct (1)

### 6. Upload to Internal Testing
- Go to "Testing" > "Internal testing"
- Create new release
- Upload AAB file
- Add release notes (from RELEASE_NOTES.md)
- Save and review
- Add testers (email addresses)

### 7. Test the Release
- Test on real devices
- Verify all features work
- Check calculator functionality
- Test notes creation and search
- Test QR scanner (if camera available)
- Verify dark mode
- Check offline functionality

### 8. Move to Production
- Once internal testing passes, go to "Production"
- Create new release
- Upload the same AAB (or updated version)
- Add release notes
- Complete content rating (if not done)
- Complete data safety section (if not done)

### 9. Host Privacy Policy
- Upload PRIVACY_POLICY.md to a web server
- Common options:
  - GitHub Pages (free)
  - Google Sites (free)
  - Your own website
  - Privacy policy generators with hosting
- Get public URL (e.g., https://yourdomain.com/privacy-policy)
- Add URL in Play Console under "App content" > "Privacy policy"

### 10. Review and Publish
- Review all sections for completeness
- Check for any warnings or errors
- Ensure all required assets are uploaded
- Submit for review
- Wait for Google's review (typically 1-3 days)

## Post-Publication

### Monitor
- [ ] Check for user reviews
- [ ] Monitor crash reports (if enabled)
- [ ] Track download statistics
- [ ] Respond to user feedback

### Updates
- [ ] Plan future updates
- [ ] Update release notes for new versions
- [ ] Keep privacy policy updated
- [ ] Maintain app compatibility

## Important Notes

### Required Before Publishing:
1. **Feature Graphic**: Must create 1024x500px promotional banner
2. **Screenshots**: Need minimum 2 phone screenshots
3. **Privacy Policy URL**: Must host PRIVACY_POLICY.md and provide URL
4. **AAB File**: Build Android App Bundle (better than APK)
5. **Content Rating**: Complete questionnaire in Play Console
6. **Data Safety**: Complete data safety form in Play Console

### Optional but Recommended:
- More screenshots (4-8 ideal)
- Tablet screenshots
- Promotional video (YouTube)
- Store listing experiments (A/B testing)

### Account Requirements:
- Google Play Developer account ($25 one-time fee)
- Tax and payment information (even for free apps)
- Account verification (may take a few days)

## Support Information
- **Developer Name**: OPALWISH (OPC) PRIVATE LIMITED
- **Contact Email**: opalwishopc1997@gmail.com
- **App Website**: (Add if available)


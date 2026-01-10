# Google Play Data Safety Form Responses

Use this as a guide when completing the Data Safety section in Google Play Console.

## Does your app collect or share any of the following data types?

**Answer: NO to all data types**

### Personal Info
- Name: **No**
- Email address: **No**
- User IDs: **No**
- Address: **No**
- Phone number: **No**
- Race and ethnicity: **No**
- Political or religious beliefs: **No**
- Sexual orientation: **No**
- Other personal info: **No**

### Financial Info
- User payment info: **No**
- Purchase history: **No**
- Credit score: **No**
- Other financial info: **No**

### Health and Fitness
- Health info: **No**
- Fitness info: **No**

### Messages
- Emails: **No**
- SMS or MMS: **No**
- Other in-app messages: **No**

### Photos and Videos
- Photos: **No**
- Videos: **No**

### Audio Files
- Voice or sound recordings: **No**
- Music files: **No**
- Other audio files: **No**

### Files and Docs
- Files and docs: **No**

### Calendar
- Calendar events: **No**

### Contacts
- Contacts: **No**

### App Activity
- App interactions: **No**
- In-app search history: **No**
- Installed apps: **No**
- Other user-generated content: **No**
- Other actions: **No**

### Web Browsing
- Web browsing history: **No**

### App Info and Performance
- Crash logs: **No**
- Diagnostics: **No**
- Other app performance data: **No**

### Device or Other IDs
- Device or other IDs: **No**

## Data Sharing
**Answer: NO**

- Does your app share collected user data with third parties? **No**

## Data Security
**Answer: YES**

- Is all user data encrypted in transit? **N/A (no data collected)**
- Do you provide a way for users to request deletion of their data? **Yes** (users can uninstall app or clear app data)

## Permissions Declaration

### Camera Permission
- **Permission**: android.permission.CAMERA
- **Why it's needed**: To scan QR codes and barcodes
- **Is it optional?**: **Yes** - Users can deny this permission and still use Calculator and Notes features
- **When is it used?**: Only when user actively uses the QR Scanner feature
- **Data collected**: No data is collected. Camera is used in real-time for scanning only. Only the text content extracted from QR codes is stored locally on the device.

## Data Handling Practices

### Data Collection
- **Does your app collect data?**: **No**

### Data Storage
- **Where is data stored?**: Locally on device only
- **Is data encrypted?**: Data is protected by device security measures
- **Is data transmitted off device?**: **No**

### Data Usage
- **What is data used for?**: Data (notes, calculator history, QR scan history) is only used within the app for user's convenience
- **Is data used for advertising?**: **No**
- **Is data used for analytics?**: **No**
- **Is data used for tracking?**: **No**

### User Control
- **Can users request data deletion?**: **Yes** - Users can:
  - Uninstall the app (deletes all data)
  - Clear app data in device settings
  - Delete individual notes/calculations/scans within the app

## Summary Statement for Data Safety Section

**Recommended text to use in Play Console:**

"TapKit does not collect, share, or transmit any user data. All app data (notes, calculator history, QR scan history) is stored locally on the user's device only. The optional camera permission is only used for QR code scanning when the user actively uses that feature. No data is collected, transmitted, or shared with third parties. Users have full control over their data and can delete it at any time by uninstalling the app or clearing app data."

## COPPA Compliance
- **Is your app primarily designed for children?**: No
- **Does your app knowingly collect data from children?**: No (app doesn't collect any data)
- **Is your app subject to COPPA?**: No (no data collection)

## GDPR Compliance
- **Does your app comply with GDPR?**: Yes
- **Reason**: The app does not collect, process, or store any personal data. All data is stored locally on the user's device and is never transmitted to external servers.

## Important Notes

1. Be honest and accurate in your responses
2. If your data practices change in future updates, you must update this section
3. Google may audit your responses
4. Providing false information can result in app removal

## Verification Checklist

Before submitting, verify:
- [ ] All data collection questions answered "No"
- [ ] Data sharing question answered "No"
- [ ] Camera permission properly declared as optional
- [ ] Summary statement accurately reflects your app's data practices
- [ ] Privacy policy URL is provided and accessible
- [ ] Privacy policy matches the data safety responses


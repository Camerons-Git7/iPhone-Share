# iOS Screen Share App

Builds IPA using GitHub Actions.

## Setup Required

1. Apple Developer Account ($99/year)
2. Create App ID: com.yourapp.screenshare
3. Create App Group: group.com.yourapp.screenshare
4. Create provisioning profiles
5. Add secrets to GitHub repository

## GitHub Secrets

- BUILD_CERTIFICATE_BASE64
- P12_PASSWORD
- BUILD_PROVISION_PROFILE_BASE64
- KEYCHAIN_PASSWORD

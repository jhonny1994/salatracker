# Release Signing and Env Validation

This project validates signing and runtime environment values in CI before
building release artifacts.

## Required GitHub Secrets

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `SENTRY_DSN`
- `SENTRY_ENV`

## Workflow Coverage

- `.github/workflows/ci.yml`
  - format check
  - analyze
  - tests with coverage
- `.github/workflows/android-release.yml`
  - secret presence validation
  - release signing file generation
  - signed sideload APK + signed Play AAB build (flavor-based)
  - APK SHA256 generation and artifact upload
  - artifact retention (30 days)
  - release tag creation

## In-App Update Release Runbook

1. Trigger `android-release.yml` with the release tag.
2. Download release artifacts:
   - `app-sideload-release.apk`
   - `app-play-release.aab`
   - `artifacts_apk_sha256.txt`
3. Update `update-manifest.json`:
   - `latest_version_code`
   - `min_supported_version_code` (if policy changes)
   - `recommended_version_code`
   - `apk_url` (release APK URL)
   - `store_url` (Play listing URL)
   - `release_notes_url`
   - `sha256` from `artifacts_apk_sha256.txt`
4. Commit and push manifest update.
5. Verify in-app Settings update tile detects the new version.

## Local Signing Setup

1. Copy `android/key.properties.example` to `android/key.properties`.
2. Set real keystore values in `android/key.properties`.
3. Put keystore file at `android/upload-keystore.jks`.

## Notes

- Release builds use debug signing when `android/key.properties` is absent.
- CI release workflow requires signing secrets and fails fast if missing.

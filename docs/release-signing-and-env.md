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
  - signed APK + AAB build
  - artifact retention (30 days)
  - release tag creation

## Local Signing Setup

1. Copy `android/key.properties.example` to `android/key.properties`.
2. Set real keystore values in `android/key.properties`.
3. Put keystore file at `android/upload-keystore.jks`.

## Notes

- Release builds use debug signing when `android/key.properties` is absent.
- CI release workflow requires signing secrets and fails fast if missing.

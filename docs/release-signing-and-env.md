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
  - update manifest auto-generation from the built sideload APK
  - manifest validation against release filename/build number/SHA contract
  - GitHub Pages deployment for `update-manifest.json`
  - artifact retention (30 days)
  - release tag creation

## In-App Update Release Runbook

1. Trigger `android-release.yml` with the release tag.
2. Download release artifacts:
   - `app-sideload-release.apk`
   - `app-play-release.aab`
   - `artifacts_apk_sha256.txt`
3. The workflow auto-generates `update-manifest.json` from the built
   `app-sideload-release.apk` artifact and its computed SHA256.
4. The workflow publishes the GitHub release, verifies the sideload download
   URL, then deploys the manifest to GitHub Pages.
5. Verify the Pages manifest URL is live:
   - `https://jhonny1994.github.io/salatracker/update-manifest.json`
6. Verify in-app Settings update tile detects the new version.

## Local Signing Setup

1. Copy `android/key.properties.example` to `android/key.properties`.
2. Set real keystore values in `android/key.properties`.
3. Put keystore file at `android/upload-keystore.jks`.

## Notes

- Release builds use debug signing when `android/key.properties` is absent.
- CI release workflow requires signing secrets and fails fast if missing.
- The sideload update path must stay aligned to `app-sideload-release.apk`.
- The live sideload manifest is served from GitHub Pages, not `raw/main`.

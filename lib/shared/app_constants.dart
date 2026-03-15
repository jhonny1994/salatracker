/// Application-wide constants.
library;

abstract class AppConstants {
  /// The official support email address for the application.
  static const String supportEmail = 'douadi.med.abderraouf@gmail.com';

  /// The default subject line for feedback/support emails.
  static const String feedbackSubject = 'Salat Tracker Feedback';

  /// Owner/repo slug used for GitHub release and manifest checks.
  static const String githubRepoSlug = 'jhonny1994/salatracker';

  /// Project-hosted update manifest URL for sideload releases.
  static const String updateManifestUrl =
      'https://jhonny1994.github.io/salatracker/update-manifest.json';

  /// Public Play Store listing URL.
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.carbodex.salat_tracker';

  /// Expected APK filename produced by CI release workflow.
  static const String releaseApkFileName = 'app-sideload-release.apk';
}

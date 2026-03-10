/// Application-wide constants.
library;

abstract class AppConstants {
  /// The official support email address for the application.
  static const String supportEmail = 'douadi.med.abderraouf@gmail.com';

  /// The default subject line for feedback/support emails.
  static const String feedbackSubject = 'Salat Tracker Feedback';

  /// Owner/repo slug used for GitHub release and manifest checks.
  static const String githubRepoSlug = 'jhonny1994/salatracker';

  /// Raw-hosted update manifest URL.
  static const String updateManifestUrl =
      'https://raw.githubusercontent.com/jhonny1994/salatracker/main/update-manifest.json';

  /// Public Play Store listing URL.
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.carbodex.salat_tracker';

  /// Expected APK filename produced by CI release workflow.
  static const String releaseApkFileName = 'app-release.apk';
}

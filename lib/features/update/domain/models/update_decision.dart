import 'package:salat_tracker/features/update/update.dart';

class UpdateDecision {
  const UpdateDecision({
    required this.status,
    required this.action,
    required this.message,
    this.graceDeadline,
    this.downloadUrl,
    this.installPath,
    this.storeUrl,
    this.sha256,
    this.error,
  });

  final UpdateStatus status;
  final UpdateAction action;
  final String message;
  final DateTime? graceDeadline;
  final String? downloadUrl;
  final String? installPath;
  final String? storeUrl;
  final String? sha256;
  final UpdateError? error;

  UpdateDecision copyWith({
    UpdateStatus? status,
    UpdateAction? action,
    String? message,
    DateTime? graceDeadline,
    String? downloadUrl,
    String? installPath,
    String? storeUrl,
    String? sha256,
    UpdateError? error,
  }) {
    return UpdateDecision(
      status: status ?? this.status,
      action: action ?? this.action,
      message: message ?? this.message,
      graceDeadline: graceDeadline ?? this.graceDeadline,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      installPath: installPath ?? this.installPath,
      storeUrl: storeUrl ?? this.storeUrl,
      sha256: sha256 ?? this.sha256,
      error: error ?? this.error,
    );
  }
}

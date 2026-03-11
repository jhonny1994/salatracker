import 'package:flutter_test/flutter_test.dart';
import 'package:salat_tracker/features/update/update.dart';

void main() {
  test('unreachable sideload apk maps to retryable error state', () {
    const decision = UpdateDecision(
      status: UpdateStatus.error,
      action: UpdateAction.retry,
      message: 'Unable to check updates right now',
      error: UpdateError.downloadFailed,
      storeUrl: 'https://play.google.com/store/apps/details?id=x',
    );

    expect(decision.status, UpdateStatus.error);
    expect(decision.action, UpdateAction.retry);
    expect(decision.error, UpdateError.downloadFailed);
    expect(decision.storeUrl, isNotEmpty);
  });
}

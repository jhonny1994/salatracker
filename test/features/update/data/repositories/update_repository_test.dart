import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:salat_tracker/features/update/update.dart';

void main() {
  group('UpdateRepository.isApkReachable', () {
    test('returns true when HEAD succeeds', () async {
      final repository = UpdateRepository(
        client: _FakeClient((request) async {
          expect(request.method, 'HEAD');
          return http.Response('', 200);
        }),
      );

      final reachable = await repository.isApkReachable(
        'https://example.com/app-release.apk',
      );

      expect(reachable, isTrue);
    });

    test('falls back to GET when HEAD is not allowed', () async {
      var calls = 0;
      final repository = UpdateRepository(
        client: _FakeClient((request) async {
          calls++;
          if (request.method == 'HEAD') {
            return http.Response('', 405);
          }
          expect(request.method, 'GET');
          expect(request.headers['Range'], 'bytes=0-0');
          return http.Response('', 206);
        }),
      );

      final reachable = await repository.isApkReachable(
        'https://example.com/app-release.apk',
      );

      expect(reachable, isTrue);
      expect(calls, 2);
    });

    test('returns false when asset is not reachable', () async {
      final repository = UpdateRepository(
        client: _FakeClient((request) async => http.Response('', 404)),
      );

      final reachable = await repository.isApkReachable(
        'https://example.com/app-release.apk',
      );

      expect(reachable, isFalse);
    });
  });
}

class _FakeClient extends http.BaseClient {
  _FakeClient(this._handler);

  final Future<http.Response> Function(http.BaseRequest request) _handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      request: request,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }
}

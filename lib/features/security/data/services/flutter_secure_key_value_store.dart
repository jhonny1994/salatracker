import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:salat_tracker/features/security/data/services/secure_key_value_store.dart';

class FlutterSecureKeyValueStore implements SecureKeyValueStore {
  FlutterSecureKeyValueStore(this._secureStorage);

  final FlutterSecureStorage _secureStorage;

  @override
  Future<void> write({required String key, required String value}) {
    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _secureStorage.delete(key: key);
  }
}

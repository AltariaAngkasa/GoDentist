import 'package:GoDentist/app/common/security_storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

extension XFlutterSecureStorage on FlutterSecureStorage {
  Future writeUserSecureData({
    required String token,
  }) async {
    write(key: SecureStorageKey.token.name, value: token);
  }
}

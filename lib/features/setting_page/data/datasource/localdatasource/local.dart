import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsDBLocalDatasource {
  Future<void> saveSession({String? tokenName, String? token});

  Future<void> saveString({String? stringName, String? value});

  Future<void> saveInt({String? intName, int? value});

  Future<String?> getToken({String? token});

  Future<String?> getString({String? key});

  Future<int> getInt({String? key, int defaultValue = 0});

  Future<void> clearToken();

  Future<bool> hasLoggedin();
}

class SessionKeys {
  // ignore: constant_identifier_names
  static const String CLIENT_TOKEN = "client_token";

  static get refreshToken => "refresh_token";

  static get tokenType => "token_type";

  static get user => "user";

  static get password => 'password';

  static get accessTokenGrantType => "access_token_grant_type";

  static get accessTokenExpiresIn => "access_token_expires";

  static get accessTokenPart1 => "partone";

  static get accessTokenPart2 => "parttwo";

  static get accessTokenPart3 => "partthree";

  static get hasLoggedIn => "hasloggedin";
}

class SettingsDBLocalDatasourceImpl extends SettingsDBLocalDatasource {
  SettingsDBLocalDatasourceImpl(
      {required this.secureStorage, required this.sharedPreferences});

  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  @override
  Future<String?> getToken({String? token}) async {
    var data = await secureStorage.read(
      key: token!,
    );
    return data;
  }

  @override
  Future<void> saveSession({String? tokenName, String? token}) async {
    await secureStorage.write(
      key: tokenName!,
      value: token,
    );
  }

  @override
  Future<String?> getString({String? key}) async {
    var data = await secureStorage.read(key: key!);
    return data;
  }

  @override
  Future<void> saveString({String? stringName, String? value}) async {
    await secureStorage.write(key: stringName!, value: value);
  }

  @override
  Future<void> saveInt({String? intName, int? value}) async {
    await sharedPreferences.setInt(intName!, value!);
  }

  @override
  Future<void> clearToken() async {
    await secureStorage.write(key: SessionKeys.accessTokenPart1, value: '');
    await secureStorage.write(key: SessionKeys.accessTokenPart2, value: '');
    await secureStorage.write(key: SessionKeys.accessTokenPart3, value: '');
    await secureStorage.write(key: SessionKeys.refreshToken, value: '');
    await secureStorage.write(key: SessionKeys.user, value: '');
    // await secureStorage.write(key: SessionKeys.password, value: '');
    await sharedPreferences.setInt(SessionKeys.accessTokenExpiresIn, 0);
  }

  @override
  Future<int> getInt({String? key, int defaultValue = 0}) async {
    var value = sharedPreferences.getInt(key!);
    return value ?? defaultValue;
  }

  @override
  Future<bool> hasLoggedin() async {
    var value = sharedPreferences.getInt(SessionKeys.hasLoggedIn);
    if (value == null || value == 0) {
      return false;
    } else {
      return true;
    }
  }
}

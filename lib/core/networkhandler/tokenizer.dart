import 'dart:convert';

class Tokenizer {
  Tokenizer._();

  static Map<String, dynamic> parseJwt(String? token) {
    try {
      final parts = token?.split('.');
      if (parts?.length != 3) {
        throw "Invalid token"; //TokenizerException('Invalid token');
      }

      final payload = _decodeBase64(parts![1]);
      final payloadMap = json.decode(payload);
      if (payloadMap is! Map<String, dynamic>) {
        throw "Invalid payload"; //TokenizerException('Invalid payload');
      }

      return payloadMap;
    } catch (e) {
      throw e;
    }
  }

  static String _decodeBase64(String str) {
    try {
      String output = str.replaceAll('-', '+').replaceAll('_', '/');

      switch (output.length % 4) {
        case 0:
          break;
        case 2:
          output += '==';
          break;
        case 3:
          output += '=';
          break;
        default:
          throw "Illegal base64url string!"; //TokenizerException('Illegal base64url string!"');
      }

      return utf8.decode(base64Url.decode(output));
    } catch (e) {
      throw e;
    }
  }
}

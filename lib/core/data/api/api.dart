import 'dart:convert';
import 'package:crypto/crypto.dart';

class API {
  static const String mainURL = 'http://127.0.0.1:5000';
  static String getPasswordHash(String password, String salt) {
    String result = '$password$salt';
    for (var i = 0; i < 1530; i++) {
      List<int> bytes = utf8.encode('$result$salt');
      result = sha256.convert(bytes).toString();
    }
    return result;
  }
}

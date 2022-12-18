import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) =>
    String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class AuthAPIMethods {
  static Future<String?> registerUser(String username, String password) async {
    String? token;
    String salt = getRandomString(100);
    String hash = await API.getPasswordHash(password, salt);
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/registration'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': username,
        'salt': salt,
        'password_hash': hash,
      }),
    );
    if (response.statusCode == 200) {
      token = jsonDecode(response.body)['token'];
      return token;
    } else {
      return null;
    }
  }

  static Future<String?> loginUser(String username, String password) async {
    String? token;
    http.Response response = await http.get(
      Uri.parse('${API.mainURL}/salt'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'username': username,
      },
    );
    String salt;
    if (response.statusCode == 200) {
      salt = jsonDecode(response.body)['salt'];
    } else {
      return null;
    }
    String hash = await API.getPasswordHash(password, salt);
    response = await http.get(
      Uri.parse('${API.mainURL}/token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'username': username,
        'password_hash': hash,
      },
    );
    if (response.statusCode == 200) {
      token = jsonDecode(response.body)['token'];
      return token;
    } else {
      return null;
    }
  }
}

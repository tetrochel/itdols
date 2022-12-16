import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

class RoutesAPIMethods {
  static Future<List<RouteModel>?> getRoutes(String token) async {
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/routes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      List<RouteModel> routes = await jsonDecode(response.body).map((e) => RouteModel.fromMap(e)).toList();
      return routes;
    } else {
      return null;
    }
  }
}

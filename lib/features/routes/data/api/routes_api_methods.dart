import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

class RoutesAPIMethods {
  static Future<List<RouteModel>?> getRoutes(String token) async {
    http.Response response = await http.get(
      Uri.parse('${API.mainURL}/routes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      var rawRoutes = await jsonDecode(response.body);
      List<RouteModel> routes =
          List<RouteModel>.generate(rawRoutes.length, (index) => RouteModel.fromMap(rawRoutes[index]));
      return routes;
    } else {
      return null;
    }
  }

  static Future<bool> setRoute(String token, RouteModel route) async {
    http.Response response = await http.put(
      Uri.parse('${API.mainURL}/routes/${route.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
      body: route.toJson(),
    );
    return response.statusCode == 200;
  }
}

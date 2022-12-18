import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class PlacesAPIMethods {
  static Future<List<PlaceModel>?> getPlaces(String token) async {
    http.Response response = await http.get(
      Uri.parse('${API.mainURL}/places'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      var rawPlaces = await jsonDecode(response.body);
      List<PlaceModel> places =
          List<PlaceModel>.generate(rawPlaces.length, (index) => PlaceModel.fromMap(rawPlaces[index]));
      return places;
    } else {
      return null;
    }
  }

  static Future<bool> addPlace(String token, String name) async {
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/places'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
      body: json.encode({'name': name}),
    );
    return response.statusCode == 200;
  }
}

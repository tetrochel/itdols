import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/calculation/domain/models/way.dart';
import 'package:itdols/features/calculation/domain/way_component.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

class WaysAPIMethods {
  static Future<List<WayModel>?> getWays(String token, PlaceModel first, PlaceModel second) async {
    http.Response response = await http.get(
      Uri.parse('${API.mainURL}/min_way'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
        'start': first.id.toString(),
        'end': second.id.toString(),
      },
    );
    if (response.statusCode == 200) {
      List<WayModel> ways = [];
      var rawWays = await jsonDecode(response.body);
      print(rawWays);
      for (var rawWay in rawWays['ways']) {
        List<WayComponent> way = [];
        List<JobModel> xjobs =
            List<JobModel>.generate(rawWay['xjobs'].length, (index) => JobModel.fromMap(rawWay['xjobs'][index]));
        List<JobModel> jobs =
            List<JobModel>.generate(rawWay['jobs'].length, (index) => JobModel.fromMap(rawWay['jobs'][index]));
        List<RouteModel> routes =
            List<RouteModel>.generate(rawWay['routes'].length, (index) => RouteModel.fromMap(rawWay['routes'][index]));
        for (var route in routes) {
          way.addAll(jobs.where((element) => element.place == route.firstPlace));
          way.add(route);
        }

        way.addAll(jobs.where((element) => element.place == routes.last.secondPlace));
        ways.add(WayModel(finalRoute: way, xjobs: xjobs));
      }
      return ways;
    } else {
      return null;
    }
  }
}

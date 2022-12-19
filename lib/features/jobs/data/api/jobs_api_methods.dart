import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class JobesAPIMethods {
  static Future<List<JobModel>?> getJobs(String token) async {
    http.Response response = await http.get(
      Uri.parse('${API.mainURL}/jobs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      var rawJobs = await jsonDecode(response.body);
      List<JobModel> jobs = List<JobModel>.generate(rawJobs.length, (index) => JobModel.fromMap(rawJobs[index]));
      return jobs;
    } else {
      return null;
    }
  }

  static Future<bool> addJob(String token, String name, int duration, PlaceModel place) async {
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/jobs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
      body: json.encode({
        'name': name,
        'duration': duration,
        'place': place.toMap(),
      }),
    );
    return response.statusCode == 200;
  }

  static Future<bool> setJob(String token, JobModel job) async {
    http.Response response = await http.put(
      Uri.parse('${API.mainURL}/jobs/${job.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
      body: job.toJson(),
    );
    return response.statusCode == 200;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';

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
}

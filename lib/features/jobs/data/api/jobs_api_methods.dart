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
      var raw_jobs = await jsonDecode(response.body);
      List<JobModel> jobs = List<JobModel>.generate(raw_jobs.length, (index) => JobModel.fromMap(raw_jobs[index]));
      return jobs;
    } else {
      return null;
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itdols/core/data/api/api.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';

class JobesAPIMethods {
  static Future<List<JobModel>?> getJobs(String token) async {
    http.Response response = await http.post(
      Uri.parse('${API.mainURL}/jobs'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      List<JobModel> jobs = await jsonDecode(response.body).map((e) => JobModel.fromMap(e)).toList();
      return jobs;
    } else {
      return null;
    }
  }
}

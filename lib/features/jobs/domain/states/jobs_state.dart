import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';

StateNotifierProvider<JobsStateHolder, List<JobModel>?> jobsStateHolder =
    StateNotifierProvider<JobsStateHolder, List<JobModel>?>(
  (ref) => JobsStateHolder(null),
);

class JobsStateHolder extends StateNotifier<List<JobModel>?> {
  JobsStateHolder(super.state);

  void setAll(List<JobModel> jobs) {
    state = [...jobs];
  }
}

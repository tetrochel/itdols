import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/domain/states/jobs_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

Provider<JobsController> jobsController = Provider<JobsController>(
  (ref) => JobsController(
    jobsStateHolder: ref.watch(jobsStateHolder.notifier),
  ),
);

class JobsController {
  final JobsStateHolder jobsStateHolder;
  JobsController({
    required this.jobsStateHolder,
  });

  Future getJobs() async {
    List<JobModel> jobs = [];
    await Future.delayed(const Duration(seconds: 1));
    jobs = [
      JobModel(
        'Вещи постирать',
        '058fb1be-329c-4e01-9bbe-cfe9f68c5c8f',
        PlaceModel('Дом', '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'),
        70,
      ),
      JobModel(
        'Работать',
        '058fb1be-329c-4e01-9bbe-cfe9f68c5c8f',
        PlaceModel('Работа', '7725233e-1db2-4c80-9db2-db9415fb777a'),
        240,
      ),
      JobModel(
        'Кушать',
        '058fb1be-329c-4e01-9bbe-cfe9f68c5c8f',
        PlaceModel('Кафе', '36b8a6da-fc33-4e0a-a64c-e9e41dfaf2e5'),
        30,
      ),
      JobModel(
        'Внести правки в книгу',
        '058fb1be-329c-4e01-9bbe-cfe9f68c5c8f',
        PlaceModel('Редакция', '1dca6467-92ae-4d65-b44a-353b5918930a'),
        120,
      ),
    ];
    jobsStateHolder.setAll(jobs);
  }
}

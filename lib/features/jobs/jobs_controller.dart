import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/features/jobs/data/api/jobs_api_methods.dart';
import 'package:itdols/features/places/data/api/places_api_methods.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/domain/states/jobs_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/domain/states/places_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(WidgetState.loading),
);

StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?> placesStateHolder =
    StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?>(
  (ref) => PlacesStateHolder(null),
);

Provider<JobsController> jobsController = Provider<JobsController>(
  (ref) => JobsController(
    jobsStateHolder: ref.watch(jobsStateHolder.notifier),
    placesStateHolder: ref.watch(placesStateHolder.notifier),
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
    userStateHolder: ref.watch(userStateHolder.notifier),
  ),
);

class JobsController {
  final JobsStateHolder jobsStateHolder;
  final PlacesStateHolder placesStateHolder;
  final WidgetStateHolder widgetStateHolder;
  final UserStateHolder userStateHolder;
  JobsController({
    required this.jobsStateHolder,
    required this.placesStateHolder,
    required this.widgetStateHolder,
    required this.userStateHolder,
  });

  Future getJobs() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);
    List<JobModel>? jobs = [];
    jobs = await JobsAPIMethods.getJobs(userStateHolder.getUser()!.token);
    bool isOK = await getPlaces();
    if (isOK) {
      if (jobs == null) {
        jobsStateHolder.setAll([]);
        widgetStateHolder.setWidgetState(WidgetState.error);
      } else {
        jobsStateHolder.setAll(jobs);
        widgetStateHolder.setWidgetState(WidgetState.loaded);
      }
    } else {
      jobsStateHolder.setAll([]);
      widgetStateHolder.setWidgetState(WidgetState.error);
    }
  }

  Future<bool> getPlaces() async {
    List<PlaceModel>? places = [];
    places = await PlacesAPIMethods.getPlaces(userStateHolder.getUser()!.token);
    if (places == null) {
      placesStateHolder.setAll([]);
    } else {
      placesStateHolder.setAll(places);
    }
    return places != null;
  }

  Future<bool> addJob(String name, int duration, PlaceModel place) async {
    String token = userStateHolder.getUser()!.token;
    return await JobsAPIMethods.addJob(token, name, duration, place);
  }

  Future<bool> setJob(JobModel job) async {
    String token = userStateHolder.getUser()!.token;
    return await JobsAPIMethods.setJob(token, job);
  }

  Future<bool> deleteJob(JobModel job) async {
    String token = userStateHolder.getUser()!.token;
    return await JobsAPIMethods.deleteJob(token, job);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/error_page.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/domain/states/jobs_state.dart';
import 'package:itdols/features/jobs/jobs_controller.dart';
import 'package:itdols/features/jobs/presentation/job_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

// ignore: must_be_immutable
class JobsPage extends ConsumerWidget {
  JobsPage({super.key});

  List<JobModel>? jobs;
  List<PlaceModel>? places;
  WidgetState? widgetState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    jobs = ref.watch(jobsStateHolder);
    places = ref.watch(placesStateHolder);
    if (jobs == null) {
      ref.read(jobsController).getJobs();
    }
    if (places == null) {
      ref.read(jobsController).getPlaces();
    }
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        HeaderWidget(
          label: 'Список дел',
          actions: [
            ElevatedButton(
              onPressed: () {
                // TODO: go to job create screen
              },
              child: const Text('Добавить'),
            )
          ],
        ),
        if (widgetState == WidgetState.loaded && jobs != null && places != null)
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: jobs!.length,
              itemBuilder: (BuildContext context, int index) => JobWidget(
                job: jobs![index],
                places: places!,
              ),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            ),
          )
        else if (widgetState == WidgetState.error)
          ErrorPage(onPressed: () {
            ref.read(jobsController).getJobs();
            ref.read(jobsController).getPlaces();
          })
        else
          const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}

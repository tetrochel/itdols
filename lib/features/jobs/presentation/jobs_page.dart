import 'package:flutter/material.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/presentation/job_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  List<JobModel> jobs = [
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(
          label: 'Список дел',
          actions: [
            ElevatedButton(
              onPressed: () {
                // TODO
              },
              child: const Text('Добавить'),
            )
          ],
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: jobs.length,
            itemBuilder: (BuildContext context, int index) => JobWidget(job: jobs[index]),
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
        ),
      ],
    );
  }
}

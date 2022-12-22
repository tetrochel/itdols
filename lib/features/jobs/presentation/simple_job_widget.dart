import 'package:flutter/material.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/presentation/place_widget.dart';

class SimpleJobWidget extends StatelessWidget {
  const SimpleJobWidget({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 26,
                width: 400,
                child: Text(
                  job.name,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              PlaceWidget(place: job.place),
            ],
          ),
          const Spacer(),
          Text(job.getTimeString()),
        ],
      ),
    );
  }
}

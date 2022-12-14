import 'package:flutter/material.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({super.key, required this.job});

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.name,
                style: const TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Color(0xAA000000 + int.parse(job.place.id.substring(2, 8), radix: 16)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    job.place.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Text(job.getTimeString()),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {
              // TODO
            },
            child: const Text(
              'Изменить',
            ),
          )
        ],
      ),
    );
  }
}

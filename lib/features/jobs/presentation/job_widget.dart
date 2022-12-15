import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/jobs/domain/models/job_model.dart';
import 'package:itdols/features/jobs/jobs_controller.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class JobWidget extends ConsumerStatefulWidget {
  const JobWidget({super.key, required this.job, required this.places});

  final JobModel job;
  final List<PlaceModel> places;

  @override
  JobWidgetState createState() => JobWidgetState();
}

class JobWidgetState extends ConsumerState<JobWidget> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  PlaceModel? newPlace;

  @override
  Widget build(BuildContext context) {
    newPlace ??= widget.job.place;
    return Padding(
      padding: const EdgeInsets.all(8).copyWith(left: 5),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: 400,
                child: isEditing
                    ? TextFormField(
                        controller: nameController,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Text(
                          widget.job.name,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
              ),
              const SizedBox(height: 4),
              isEditing
                  ? SizedBox(
                      width: 200,
                      height: 36,
                      child: DropdownButtonFormField<PlaceModel>(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                          border: OutlineInputBorder(),
                        ),
                        value: newPlace,
                        items: widget.places.map<DropdownMenuItem<PlaceModel>>((e) {
                          return DropdownMenuItem<PlaceModel>(
                            value: e,
                            child: _PlaceWidget(place: e),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() {
                          newPlace = value;
                        }),
                      ),
                    )
                  : Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        _PlaceWidget(place: widget.job.place),
                      ],
                    ),
            ],
          ),
          const Spacer(),
          isEditing
              ? Row(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 26,
                      child: TextFormField(
                        textAlign: TextAlign.end,
                        controller: durationController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        ),
                      ),
                    ),
                    const Text(' мин'),
                  ],
                )
              : Text(widget.job.getTimeString()),
          const SizedBox(
            width: 10,
          ),
          isEditing
              ? Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => finishEditing(context),
                      child: const Text(
                        'Сохранить',
                      ),
                    ),
                    const SizedBox(width: 4),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => finishEditing(context), // TODO
                      child: const Text(
                        'Удалить',
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => setState(() {
                        isEditing = false;
                      }),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                )
              : TextButton(
                  onPressed: startEditing,
                  child: const Text(
                    'Изменить',
                  ),
                ),
        ],
      ),
    );
  }

  void startEditing() {
    setState(() {
      isEditing = true;
    });
    nameController.text = widget.job.name;
    durationController.text = widget.job.duration.toString();
  }

  void finishEditing(BuildContext context) async {
    if (nameController.text.isEmpty) {
      showMessage('Введите непустое название дела!', context);
      return;
    }
    final int? value = int.tryParse(durationController.text);
    if (value == null) {
      showMessage('Введите целое число!', context);
      return;
    }
    if (value <= 0) {
      showMessage('Введите положительное число!', context);
      return;
    }
    setState(() {
      isEditing = false;
    });
    await ref.read(jobsController).setJob(widget.job.copyWith(
          name: nameController.text,
          duration: value,
          place: newPlace,
        ));
    await ref.read(jobsController).getJobs();
  }
}

class _PlaceWidget extends StatelessWidget {
  const _PlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlaceColorCircle(size: 12, id: place.id),
        const SizedBox(
          width: 4,
        ),
        Text(
          place.name,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

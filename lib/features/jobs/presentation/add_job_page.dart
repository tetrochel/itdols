import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/features/jobs/jobs_controller.dart';
import 'package:itdols/features/jobs/presentation/place_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class AddJobPage extends ConsumerStatefulWidget {
  const AddJobPage({super.key});

  @override
  ConsumerState<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends ConsumerState<AddJobPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  PlaceModel? choosedPlace;
  List<PlaceModel>? places;

  @override
  Widget build(BuildContext context) {
    places = ref.read(placesStateHolder);
    if (places!.isEmpty) {
      choosedPlace = null;
    }
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Добавление дела',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Название задачи',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    style: const TextStyle(fontSize: 20),
                    controller: durationController,
                    decoration: const InputDecoration(
                      labelText: 'Продолжительность (мин)',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: DropdownButtonFormField<PlaceModel>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(),
                    ),
                    value: choosedPlace,
                    items: places!.map<DropdownMenuItem<PlaceModel>>((e) {
                      return DropdownMenuItem<PlaceModel>(
                        value: e,
                        child: PlaceWidget(place: e),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      choosedPlace = value;
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => addJob(context, ref),
                    child: const Text(
                      'Добавить',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Отмена',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addJob(BuildContext context, WidgetRef ref, [bool mounted = true]) async {
    String name = nameController.text.trim();
    final int? duration = int.tryParse(durationController.text);
    if (name.isEmpty) {
      showMessage('Введите название дела!', context);
      return;
    }
    if (duration == null) {
      showMessage('Введите целое число!', context);
      return;
    }
    if (duration <= 0) {
      showMessage('Введите положительное число!', context);
      return;
    }
    if (choosedPlace == null) {
      showMessage('Выберите место!', context);
      return;
    }
    if (!await ref.read(jobsController).addJob(name, duration, choosedPlace!)) {
      showMessage('Ошибка сети!', context);
    }
    await ref.read(jobsController).getJobs();
    if (!mounted) return;
    Navigator.pop(context);
  }
}

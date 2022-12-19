import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/features/places/places_controller.dart';

class AddPlacePage extends ConsumerWidget {
  AddPlacePage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Добавление места',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    autofocus: true,
                    style: const TextStyle(fontSize: 20),
                    controller: controller,
                    onFieldSubmitted: (value) => addPlace(context, ref),
                    decoration: const InputDecoration(
                      labelText: 'Название локации',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => addPlace(context, ref),
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

  Future addPlace(BuildContext context, WidgetRef ref, [bool mounted = true]) async {
    String name = controller.text.trim();
    if (name.isEmpty) {
      showMessage('Введите название места!', context);
      return;
    }
    if (!await ref.read(placesController).addPlace(name)) {
      showMessage('Ошибка сети!', context);
    }
    await ref.read(placesController).getPlaces();
    if (!mounted) return;
    Navigator.pop(context);
  }
}

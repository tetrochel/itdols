import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/features/places/places_controller.dart';

class AddPlacePage extends ConsumerStatefulWidget {
  const AddPlacePage({super.key});

  @override
  ConsumerState<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends ConsumerState<AddPlacePage> {
  final TextEditingController controller = TextEditingController();

  bool isSending = false;

  @override
  Widget build(BuildContext context) {
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
                    onFieldSubmitted: isSending ? null : (value) => addPlace(context, ref),
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
                    onPressed: isSending ? null : () => addPlace(context, ref),
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
    setState(() {
      isSending = true;
    });
    if (name.isEmpty) {
      showMessage('Введите название места!', context);
      return;
    }
    if (!await ref.read(placesController).addPlace(name)) {
      showMessage('Ошибка сети!', context);
      setState(() {
        isSending = false;
      });
    }
    await ref.read(placesController).getPlaces();
    if (!mounted) return;
    Navigator.pop(context);
  }
}

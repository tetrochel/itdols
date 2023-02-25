import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/places_controller.dart';
import 'dart:io' show Platform;

class PlaceWidget extends ConsumerStatefulWidget {
  const PlaceWidget({super.key, required this.place});

  final PlaceModel place;

  @override
  PlaceWidgetState createState() => PlaceWidgetState();
}

class PlaceWidgetState extends ConsumerState<PlaceWidget> {
  bool isEditing = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          PlaceColorCircle(size: 18, color: widget.place.color),
          SizedBox(
            width: isEditing ? 4 : 14,
          ),
          Expanded(
            child: isEditing
                ? TextFormField(
                    onFieldSubmitted: (value) => finishEditing(context),
                    style: const TextStyle(fontSize: 20),
                    controller: controller,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  )
                : Text(
                    widget.place.name,
                    style: const TextStyle(fontSize: 20),
                  ),
          ),
          const SizedBox(
            width: 4,
          ),
          isEditing
              ? Row(
                  children: [
                    Platform.isAndroid || Platform.isIOS
                        ? IconButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => finishEditing(context),
                            icon: const Icon(Icons.done),
                          )
                        : ElevatedButton(
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
                    Platform.isAndroid || Platform.isIOS
                        ? IconButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => deletePlace(context),
                            icon: const Icon(Icons.delete),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => deletePlace(context),
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
    focusNode.requestFocus();
    controller.text = widget.place.name;
  }

  void deletePlace(BuildContext context) async {
    setState(() {
      isEditing = false;
    });
    focusNode.unfocus();
    await ref.read(placesController).deletePlace(widget.place);
    await ref.read(placesController).getPlaces();
  }

  void finishEditing(BuildContext context) async {
    if (controller.text.isEmpty) {
      showMessage('Введите непустое название!', context);
      return;
    }
    focusNode.unfocus();
    if (await ref.read(placesController).setPlace(widget.place.copyWith(name: controller.text))) {
      setState(() {
        isEditing = false;
      });
      await ref.read(placesController).getPlaces();
    } else {
      showMessage('Ошибка сети!', context);
    }
  }
}

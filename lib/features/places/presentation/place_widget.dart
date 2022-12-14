import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/places_controller.dart';

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
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 42,
        child: Row(
          children: [
            Container(
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Color(0xAA000000 + int.parse(widget.place.id.substring(2, 8), radix: 16)),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: isEditing ? 4 : 14,
            ),
            isEditing
                ? SizedBox(
                    width: 200,
                    child: TextFormField(
                      onFieldSubmitted: (value) => confirm(),
                      style: const TextStyle(fontSize: 20),
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  )
                : Text(
                    widget.place.name,
                    style: const TextStyle(fontSize: 20),
                  ),
            const Spacer(),
            isEditing
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: confirm,
                    child: const Text(
                      'Сохранить',
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true;
                      });
                      focusNode.requestFocus();
                      controller.text = widget.place.name;
                    },
                    child: const Text(
                      'Изменить',
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void confirm() async {
    setState(() {
      isEditing = false;
    });
    focusNode.unfocus();
    await ref.read(placesController).addPlace(widget.place.copyWith(name: controller.text));
    await ref.read(placesController).getPlaces();
  }
}

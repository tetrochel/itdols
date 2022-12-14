import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/routes_controller.dart';

class RouteWidget extends ConsumerStatefulWidget {
  const RouteWidget({super.key, required this.route});

  final RouteModel route;

  @override
  RouteWidgetState createState() => RouteWidgetState();
}

class RouteWidgetState extends ConsumerState<RouteWidget> {
  bool isEditing = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  final Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceWidget(place: widget.route.firstPlace),
              Row(
                children: [
                  const SizedBox(width: 9),
                  Container(
                    height: 36,
                    width: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 21),
                  isEditing
                      ? Row(
                          children: [
                            const Text(
                              'Время в пути: ',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 100,
                              height: 30,
                              child: TextFormField(
                                key: _formKey,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) => confirm(),
                                style: const TextStyle(fontSize: 16),
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                              ),
                            ),
                            const Text(
                              ' мин',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : Text(
                          'Время в пути: ${widget.route.getTimeString()}',
                          style: const TextStyle(fontSize: 16),
                        ),
                ],
              ),
              _PlaceWidget(place: widget.route.secondPlace),
            ],
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
                    controller.text = widget.route.duration.toString();
                  },
                  child: const Text(
                    'Изменить',
                  ),
                )
        ],
      ),
    );
  }

  void confirm() async {
    final int? value = int.tryParse(controller.text);
    if (value == null) {
      return;
    }
    if (value <= 0) {
      return;
    }
    setState(() {
      isEditing = false;
    });
    focusNode.unfocus();
    await ref.read(routesController).setRoute(widget.route.copyWith(duration: value));
    await ref.read(routesController).getRoutes();
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
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Color(0xAA000000 + int.parse(place.id.substring(2, 8), radix: 16)),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          place.name,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/widgets/messeger.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/routes_controller.dart';
import 'dart:io' show Platform;

class RouteWidget extends ConsumerStatefulWidget {
  const RouteWidget({super.key, required this.route});

  final RouteModel route;

  @override
  RouteWidgetState createState() => RouteWidgetState();
}

class RouteWidgetState extends ConsumerState<RouteWidget> {
  bool isEditing = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller  = TextEditingController();
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
                                onFieldSubmitted: (value) => finishEditing(context),
                                style: const TextStyle(fontSize: 16),
                                controller: controller,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ),
                            ),
                            const Text(
                              ' мин',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )
                      : widget.route.duration == 0
                          ? const Text(
                              'Требуется указать время!',
                              style: TextStyle(fontSize: 16, color: Colors.redAccent),
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
                    if (!(Platform.isAndroid || Platform.isIOS)) const SizedBox(width: 4),
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
    controller.text = widget.route.duration.toString();
  }

  void finishEditing(BuildContext context) async {
    final int? value = int.tryParse(controller.text);
    if (value == null) {
      showMessage('Введите целое число!', context);
      focusNode.requestFocus();
      return;
    }
    if (value <= 0) {
      showMessage('Введите положительное число!', context);
      focusNode.requestFocus();
      return;
    }
    setState(() {
      isEditing = false;
    });
    focusNode.unfocus();
    if (!await ref.read(routesController).setRoute(widget.route.copyWith(duration: value))) {
      showMessage('Ошибка сети!', context);
    }
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
        PlaceColorCircle(size: 20, color: place.color),
        const SizedBox(
          width: 4,
        ),
        Text(
          place.name,
          softWrap: false,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

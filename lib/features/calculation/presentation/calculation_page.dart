import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/calculation/calculation_controller.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class CalculationPage extends ConsumerStatefulWidget {
  const CalculationPage({super.key});

  @override
  ConsumerState<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends ConsumerState<CalculationPage> {
  WidgetState? widgetState;

  late PlaceModel? start;
  late PlaceModel? finish;
  List<PlaceModel>? places;

  @override
  Widget build(BuildContext context) {
    places = ref.watch(placesStateHolder);
    if (places == null) {
      ref.read(calculationController).getPlaces();
    } else {
      start = places!.first;
      finish = places!.last;
    }
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        const HeaderWidget(
          label: 'Расчёт порядка выполнения дел',
        ),
        if (widgetState == WidgetState.loaded)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<PlaceModel>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(),
                    ),
                    value: start,
                    items: places!.map<DropdownMenuItem<PlaceModel>>((e) {
                      return DropdownMenuItem<PlaceModel>(
                        value: e,
                        child: _PlaceWidget(place: e),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      start = value;
                    }),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Рассчитать'),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<PlaceModel>(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      border: OutlineInputBorder(),
                    ),
                    value: finish,
                    items: places!.map<DropdownMenuItem<PlaceModel>>((e) {
                      return DropdownMenuItem<PlaceModel>(
                        value: e,
                        child: _PlaceWidget(place: e),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                      finish = value;
                    }),
                  ),
                ),
              ],
            ),
          )
        else if (widgetState == WidgetState.error)
          Container(
              // TODO: create error screen
              )
        else
          const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
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
        PlaceColorCircle(size: 12, color: place.color),
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

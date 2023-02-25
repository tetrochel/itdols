import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/calculation/calculation_controller.dart';
import 'package:itdols/features/calculation/domain/models/way.dart';
import 'package:itdols/features/calculation/domain/states/ways_state.dart';
import 'package:itdols/features/calculation/presentation/way_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'dart:io' show Platform;

class CalculationPage extends ConsumerStatefulWidget {
  const CalculationPage({super.key});

  @override
  ConsumerState<CalculationPage> createState() => _CalculationPageState();
}

class _CalculationPageState extends ConsumerState<CalculationPage> {
  WidgetState? widgetState;

  late PlaceModel? start = null;
  late PlaceModel? finish = null;
  List<PlaceModel>? places;
  List<WayModel>? ways;

  @override
  Widget build(BuildContext context) {
    places = ref.watch(placesStateHolder);
    ways = ref.watch(waysStateHolder);
    if (places == null) {
      ref.read(calculationController).getPlaces();
    } else {
      if (places!.isNotEmpty) {
        if (start == null) {
          start = places!.first;
          finish = places!.last;
        }
      } else {
        start = null;
        finish = null;
      }
    }
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        const HeaderWidget(
          label: 'Распорядок дня',
        ),
        if (widgetState == WidgetState.loaded)
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Platform.isAndroid || Platform.isIOS
                      ? Column(
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
                                onPressed: widgetState == WidgetState.loading
                                    ? null
                                    : () {
                                        ref.read(calculationController).getWays(start!, finish!);
                                      },
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
                        )
                      : Row(
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
                                onPressed: widgetState == WidgetState.loading
                                    ? null
                                    : () {
                                        ref.read(calculationController).getWays(start!, finish!);
                                      },
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
                ),
                if (ways != null)
                  if (ways!.isNotEmpty)
                    ...ways!.map((e) => WayWidget(finalRoute: e))
                  else
                    const Text('Ошибка в расчёте путей')
              ],
            ),
          )
        else if (widgetState == WidgetState.error)
          const Expanded(
              child: Center(
            child: Text(
              'Ошибка сети!',
              style: TextStyle(fontSize: 20),
            ),
          ))
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
    return SizedBox(
      width: 250,
      child: Row(
        children: [
          PlaceColorCircle(size: 12, color: place.color),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              place.name,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

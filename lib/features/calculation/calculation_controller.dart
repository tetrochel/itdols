import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/domain/states/places_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(WidgetState.loading),
);

StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?> placesStateHolder =
    StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?>(
  (ref) => PlacesStateHolder(null),
);

Provider<CalculationController> calculationController = Provider<CalculationController>(
  (ref) => CalculationController(
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
    placesStateHolder: ref.watch(placesStateHolder.notifier),
  ),
);

class CalculationController {
  final WidgetStateHolder widgetStateHolder;
  final PlacesStateHolder placesStateHolder;
  CalculationController({
    required this.widgetStateHolder,
    required this.placesStateHolder,
  });

  // TODO: contacting the API
  Future getPlaces() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);

    List<PlaceModel> places = [];
    await Future.delayed(const Duration(milliseconds: 100));
    places = [
      PlaceModel('Дом', '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'),
      PlaceModel('Работа', '7725233e-1db2-4c80-9db2-db9415fb777a'),
      PlaceModel('Учёба', 'dc2d6107-5f5a-47fe-b824-dc434d020476'),
      PlaceModel('Просто', 'f84b6392-8996-437b-9316-23250a5fcf8c'),
      PlaceModel('Редакция', '1dca6467-92ae-4d65-b44a-353b5918930a'),
      PlaceModel('Кафе', '36b8a6da-fc33-4e0a-a64c-e9e41dfaf2e5'),
    ];

    placesStateHolder.setAll(places);
    widgetStateHolder.setWidgetState(WidgetState.loaded);
  }
}
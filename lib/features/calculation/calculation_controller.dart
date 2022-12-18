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
    
    placesStateHolder.setAll(places);
    widgetStateHolder.setWidgetState(WidgetState.loaded);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/features/calculation/data/api/ways_api_methods.dart';
import 'package:itdols/features/calculation/domain/models/way.dart';
import 'package:itdols/features/calculation/domain/states/ways_state.dart';
import 'package:itdols/features/places/data/api/places_api_methods.dart';
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
    userStateHolder: ref.watch(userStateHolder.notifier),
    waysStateHolder: ref.watch(waysStateHolder.notifier),
  ),
);

class CalculationController {
  final WidgetStateHolder widgetStateHolder;
  final PlacesStateHolder placesStateHolder;
  final UserStateHolder userStateHolder;
  final WaysStateHolder waysStateHolder;
  CalculationController({
    required this.widgetStateHolder,
    required this.placesStateHolder,
    required this.userStateHolder,
    required this.waysStateHolder,
  });

  Future getPlaces() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);
    List<PlaceModel>? places = [];
    places = await PlacesAPIMethods.getPlaces(userStateHolder.getUser()!.token);
    if (places != null) {
      placesStateHolder.setAll(places);
      widgetStateHolder.setWidgetState(WidgetState.loaded);
    } else {
      widgetStateHolder.setWidgetState(WidgetState.error);
    }
  }

  Future getWays(PlaceModel first, PlaceModel second) async {
    widgetStateHolder.setWidgetState(WidgetState.loading);
    List<WayModel>? ways = [];
    ways = await WaysAPIMethods.getWays(userStateHolder.getUser()!.token, first, second);
    if (ways != null) {
      waysStateHolder.setAll(ways);
      widgetStateHolder.setWidgetState(WidgetState.loaded);
    } else {
      widgetStateHolder.setWidgetState(WidgetState.error);
    }
  }
}

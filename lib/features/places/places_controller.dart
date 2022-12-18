import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
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

Provider<PlacesController> placesController = Provider<PlacesController>(
  (ref) => PlacesController(
    placesStateHolder: ref.watch(placesStateHolder.notifier),
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
    userStateHolder: ref.watch(userStateHolder.notifier),
  ),
);

class PlacesController {
  final PlacesStateHolder placesStateHolder;
  final WidgetStateHolder widgetStateHolder;
  final UserStateHolder userStateHolder;
  PlacesController({
    required this.placesStateHolder,
    required this.widgetStateHolder,
    required this.userStateHolder,
  });

  Future getPlaces() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);
    List<PlaceModel>? places = [];
    places = await PlacesAPIMethods.getPlaces(userStateHolder.state!.token);
    if (places != null) {
      placesStateHolder.setAll(places);
      widgetStateHolder.setWidgetState(WidgetState.loaded);
    } else {
      placesStateHolder.setAll([]);
      widgetStateHolder.setWidgetState(WidgetState.error);
    }
  }

  // TODO: contacting the API
  Future setPlace(PlaceModel place) async {
    print(place);
  }

  Future<bool> addPlace(String name) async {
    String token = userStateHolder.getUser()!.token;
    return await PlacesAPIMethods.addPlace(token, name);
  }
}

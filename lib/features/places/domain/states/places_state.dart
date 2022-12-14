import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?> placesStateHolder =
    StateNotifierProvider<PlacesStateHolder, List<PlaceModel>?>(
  (ref) => PlacesStateHolder(null),
);

class PlacesStateHolder extends StateNotifier<List<PlaceModel>?> {
  PlacesStateHolder(super.state);

  void setAll(List<PlaceModel> places) {
    state = [...places];
  }
}

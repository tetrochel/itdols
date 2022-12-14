import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

StateNotifierProvider<RoutesStateHolder, List<RouteModel>?> routesStateHolder =
    StateNotifierProvider<RoutesStateHolder, List<RouteModel>?>(
  (ref) => RoutesStateHolder(null),
);

class RoutesStateHolder extends StateNotifier<List<RouteModel>?> {
  RoutesStateHolder(super.state);

  void setAll(List<RouteModel> routes) {
    state = [...routes];
  }
}

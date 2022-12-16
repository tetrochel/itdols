import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/auth/domain/states/user_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/data/api/routes_api_methods.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/domain/states/routes_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(WidgetState.loading),
);

Provider<RoutesController> routesController = Provider<RoutesController>(
  (ref) => RoutesController(
    routesStateHolder: ref.watch(routesStateHolder.notifier),
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
    userStateHolder: ref.watch(userStateHolder.notifier),
  ),
);

class RoutesController {
  final RoutesStateHolder routesStateHolder;
  final WidgetStateHolder widgetStateHolder;
  final UserStateHolder userStateHolder;
  RoutesController({
    required this.routesStateHolder,
    required this.widgetStateHolder,
    required this.userStateHolder,
  });

  Future getRoutes() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);
    List<RouteModel>? routes = [];
    routes = await RoutesAPIMethods.getRoutes(userStateHolder.state!.token);
    if (routes != null) {
      routesStateHolder.setAll(routes);
      widgetStateHolder.setWidgetState(WidgetState.loaded);
    } else {
      routesStateHolder.setAll([]);
      widgetStateHolder.setWidgetState(WidgetState.error);
    }
  }

  // TODO: contacting the API
  Future setRoute(RouteModel route) async {
    print(route);
  }
}

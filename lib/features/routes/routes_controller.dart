import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/domain/states/routes_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(null),
);

Provider<RoutesController> routesController = Provider<RoutesController>(
  (ref) => RoutesController(
    routesStateHolder: ref.watch(routesStateHolder.notifier),
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
  ),
);

class RoutesController {
  final RoutesStateHolder routesStateHolder;
  final WidgetStateHolder widgetStateHolder;
  RoutesController({
    required this.routesStateHolder,
    required this.widgetStateHolder,
  });

  // TODO: contacting the API
  Future getRoutes() async {
    widgetStateHolder.setWidgetState(WidgetState.loading);

    List<RouteModel> routes = [];
    await Future.delayed(const Duration(microseconds: 1));
    routes = [
      RouteModel(
        firstPlace: PlaceModel('Дом', '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'),
        secondPlace: PlaceModel('Работа', '7725233e-1db2-4c80-9db2-db9415fb777a'),
        duration: 30,
      ),
      RouteModel(
        firstPlace: PlaceModel('Дом', '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'),
        secondPlace: PlaceModel('Редакция', '1dca6467-92ae-4d65-b44a-353b5918930a'),
        duration: 80,
      ),
    ];

    routesStateHolder.setAll(routes);
    widgetStateHolder.setWidgetState(WidgetState.loaded);
  }

  // TODO: contacting the API
  Future setRoute(RouteModel route) async {
    print(route);
  }
}

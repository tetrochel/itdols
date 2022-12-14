import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/domain/states/routes_state.dart';

Provider<RoutesController> routesController = Provider<RoutesController>(
  (ref) => RoutesController(
    routesStateHolder: ref.watch(routesStateHolder.notifier),
  ),
);

class RoutesController {
  final RoutesStateHolder routesStateHolder;
  RoutesController({
    required this.routesStateHolder,
  });

  // TODO: contacting the API
  Future getRoutes() async {
    List<RouteModel> routes = [];
    await Future.delayed(const Duration(seconds: 1));
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
  }

  // TODO: contacting the API
  Future addRoute(RouteModel route) async {
    print(route);
  }
}

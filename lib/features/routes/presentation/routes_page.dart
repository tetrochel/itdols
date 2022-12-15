import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/domain/states/routes_state.dart';
import 'package:itdols/features/routes/presentation/route_widget.dart';
import 'package:itdols/features/routes/routes_controller.dart';

class RoutePage extends ConsumerWidget {
  RoutePage({super.key});

  List<RouteModel>? routes;
  WidgetState? widgetState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    routes = ref.watch(routesStateHolder);
    if (routes == null) {
      ref.read(routesController).getRoutes();
    }
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        const HeaderWidget(
          label: 'Список путей',
        ),
        if (widgetState == WidgetState.loaded && routes != null)
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: routes!.length,
              itemBuilder: (BuildContext context, int index) => RouteWidget(route: routes![index]),
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            ),
          )
        else if (widgetState == WidgetState.error)
          Container(
              // TODO: create error screen
              )
        else
          const Expanded(child: Center(child: CircularProgressIndicator()))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

class SimpleRouteWidget extends StatelessWidget {
  const SimpleRouteWidget({super.key, required this.route});

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Поехать в ${route.secondPlace.name}', style: const TextStyle(fontSize: 20)),
          Text(route.getTimeString()),
        ],
      ),
    );
  }
}

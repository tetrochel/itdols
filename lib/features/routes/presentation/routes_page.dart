import 'package:flutter/material.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';
import 'package:itdols/features/routes/presentation/route_widget.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  List<RouteModel> routes = [
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(
          label: 'Список путей',
          actions: [
            ElevatedButton(
              onPressed: () {
                // TODO
              },
              child: const Text('Добавить'),
            )
          ],
        ),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: routes.length,
            itemBuilder: (BuildContext context, int index) => RouteWidget(route: routes[index]),
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/presentation/place_widget.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({super.key});

  @override
  State<PlacesPage> createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  List<PlaceModel> places = [
    PlaceModel('Дом', '9b62e665-d042-4bd6-a3bd-47ad31ea0b36'),
    PlaceModel('Работа', '7725233e-1db2-4c80-9db2-db9415fb777a'),
    PlaceModel('Учёба', 'dc2d6107-5f5a-47fe-b824-dc434d020476'),
    PlaceModel('Просто', 'f84b6392-8996-437b-9316-23250a5fcf8c'),
    PlaceModel('Редакция', '1dca6467-92ae-4d65-b44a-353b5918930a'),
    PlaceModel('Кафе', '36b8a6da-fc33-4e0a-a64c-e9e41dfaf2e5'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWidget(
          label: 'Список локаций',
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
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) => PlaceWidget(place: places[index]),
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

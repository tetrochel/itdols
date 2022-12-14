import 'package:flutter/material.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/domain/models/route_model.dart';

class RouteWidget extends StatelessWidget {
  const RouteWidget({super.key, required this.route});

  final RouteModel route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceWidget(place: route.firstPlace),
              Row(
                children: [
                  const SizedBox(width: 11),
                  Container(
                    height: 40,
                    width: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Время в пути: ${route.getTimeString()}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              _PlaceWidget(place: route.secondPlace),
            ],
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // TODO: go to route change screen
            },
            child: const Text(
              'Изменить',
            ),
          )
        ],
      ),
    );
  }
}

class _PlaceWidget extends StatelessWidget {
  const _PlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Color(0xAA000000 + int.parse(place.id.substring(2, 8), radix: 16)),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          place.name,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

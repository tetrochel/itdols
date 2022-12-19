import 'package:flutter/material.dart';
import 'package:itdols/core/widgets/place_color_circle.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlaceColorCircle(size: 12, color: place.color),
        const SizedBox(
          width: 4,
        ),
        Text(
          place.name,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

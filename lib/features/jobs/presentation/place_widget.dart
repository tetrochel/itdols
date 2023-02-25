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
    return SizedBox(
      width: 250,
      child: Row(
        children: [
          PlaceColorCircle(size: 12, color: place.color),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Text(
              place.name,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

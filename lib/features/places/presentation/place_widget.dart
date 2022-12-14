import 'package:flutter/material.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({super.key, required this.place});

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Color(0xAA000000 + int.parse(place.id.substring(2, 8), radix: 16)),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            place.name,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              // TODO
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

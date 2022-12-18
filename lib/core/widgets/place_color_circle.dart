import 'package:flutter/material.dart';

class PlaceColorCircle extends StatelessWidget {
  const PlaceColorCircle({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  final double size;
  final String color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Color(0xAA000000 + int.parse(color, radix: 16)),
        shape: BoxShape.circle,
      ),
    );
  }
}

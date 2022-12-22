import 'package:flutter/material.dart';
import 'package:itdols/features/calculation/domain/models/way.dart';

class WayWidget extends StatelessWidget {
  const WayWidget({super.key, required this.finalRoute});

  final WayModel finalRoute;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Предлагаемый маршрут:',
            style: TextStyle(fontSize: 26),
          ),
          ...finalRoute.finalRoute.map((e) => e.toWidget()),
          Text(
            finalRoute.xjobs.isEmpty ? 'Исключённых дел нет' : 'Исключённые дела:',
            style: const TextStyle(fontSize: 24),
          ),
          ...finalRoute.xjobs.map((e) => e.toWidget()),
        ],
      ),
    );
  }
}

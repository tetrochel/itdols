import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.label, this.actions = const []});

  final String label;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      elevation: 2,
      color: Colors.white,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ...actions,
            ],
          ),
        ),
      ),
    );
  }
}

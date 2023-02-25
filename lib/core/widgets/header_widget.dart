import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.label, this.actionWidget});

  final String label;
  final Widget? actionWidget;

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
              Expanded(
                child: Text(
                  label,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              if (actionWidget != null) actionWidget!,
            ],
          ),
        ),
      ),
    );
  }
}

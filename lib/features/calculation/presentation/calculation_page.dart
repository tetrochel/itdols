import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/core/widgets/header_widget.dart';
import 'package:itdols/features/calculation/calculation_controller.dart';

class CalculationPage extends ConsumerWidget {
  CalculationPage({super.key});

  WidgetState? widgetState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    widgetState = ref.watch(widgetStateHolder);
    return Column(
      children: [
        const HeaderWidget(
          label: 'Расчёт порядка выполнения дел',
        ),
      ],
    );
  }
}

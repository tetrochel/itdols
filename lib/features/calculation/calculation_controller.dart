import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/core/states/widget_state.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/places/domain/states/places_state.dart';

StateNotifierProvider<WidgetStateHolder, WidgetState?> widgetStateHolder =
    StateNotifierProvider<WidgetStateHolder, WidgetState?>(
  (ref) => WidgetStateHolder(WidgetState.loaded),
);

Provider<CalculationController> calculationController = Provider<CalculationController>(
  (ref) => CalculationController(
    widgetStateHolder: ref.watch(widgetStateHolder.notifier),
  ),
);

class CalculationController {
  final WidgetStateHolder widgetStateHolder;
  CalculationController({
    required this.widgetStateHolder,
  });
}

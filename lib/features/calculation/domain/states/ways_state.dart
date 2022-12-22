import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:itdols/features/calculation/domain/models/way.dart';

StateNotifierProvider<WaysStateHolder, List<WayModel>?> waysStateHolder =
    StateNotifierProvider<WaysStateHolder, List<WayModel>?>(
  (ref) => WaysStateHolder(null),
);

class WaysStateHolder extends StateNotifier<List<WayModel>?> {
  WaysStateHolder(super.state);

  void setAll(List<WayModel> ways) {
    state = [...ways];
  }
}

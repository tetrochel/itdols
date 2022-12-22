import 'package:flutter/foundation.dart';
import 'package:itdols/features/calculation/domain/way_component.dart';

class WayModel {
  final List<WayComponent> finalRoute;
  final List<WayComponent> xjobs;
  WayModel({
    required this.finalRoute,
    required this.xjobs,
  });

  WayModel copyWith({
    List<WayComponent>? finalRoute,
    List<WayComponent>? xjobs,
  }) {
    return WayModel(
      finalRoute: finalRoute ?? this.finalRoute,
      xjobs: xjobs ?? this.xjobs,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'finalRoute': finalRoute.map((x) => x.toMap()).toList(),
  //     'xjobs': xjobs.map((x) => x.toMap()).toList(),
  //   };
  // }

  // factory FinalRouteModel.fromMap(Map<String, dynamic> map) {
  //   return FinalRouteModel(
  //     finalRoute: List<FinalRouteComponent>.from(
  //       (map['finalRoute'] as List<int>).map<FinalRouteComponent>(
  //         (x) => FinalRouteComponent.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //     xjobs: List<FinalRouteComponent>.from(
  //       (map['xjobs'] as List<int>).map<FinalRouteComponent>(
  //         (x) => FinalRouteComponent.fromMap(x as Map<String, dynamic>),
  //       ),
  //     ),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory FinalRouteModel.fromJson(String source) =>
  //     FinalRouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FinalRouteModel(finalRoute: $finalRoute, xjobs: $xjobs)';

  @override
  bool operator ==(covariant WayModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.finalRoute, finalRoute) && listEquals(other.xjobs, xjobs);
  }

  @override
  int get hashCode => finalRoute.hashCode ^ xjobs.hashCode;
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:itdols/features/places/domain/models/place_model.dart';

class RouteModel {
  final String routeID;
  final PlaceModel firstPlace;
  final PlaceModel secondPlace;
  final int duration;

  RouteModel({
    required this.routeID,
    required this.firstPlace,
    required this.secondPlace,
    required this.duration,
  });

  String getTimeString() {
    String result = '';
    if (duration >= 60) {
      result = '$result${duration ~/ 60} ч';
    }
    if (duration % 60 != 0) {
      if (result != '') {
        result = '$result, ';
      }
      result = '$result${duration % 60} мин';
    }
    return result;
  }

  RouteModel copyWith({
    String? routeID,
    PlaceModel? firstPlace,
    PlaceModel? secondPlace,
    int? duration,
  }) {
    return RouteModel(
      routeID: routeID ?? this.routeID,
      firstPlace: firstPlace ?? this.firstPlace,
      secondPlace: secondPlace ?? this.secondPlace,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'route_id': routeID,
      'first_place': firstPlace.toMap(),
      'second_place': secondPlace.toMap(),
      'duration': duration,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      routeID: map['route_id'] as String,
      firstPlace: PlaceModel.fromMap(map['first_place'] as Map<String, dynamic>),
      secondPlace: PlaceModel.fromMap(map['second_place'] as Map<String, dynamic>),
      duration: map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) => RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RouteModel(routeID: $routeID, firstPlace: $firstPlace, secondPlace: $secondPlace, duration: $duration)';
  }

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;

    return other.routeID == routeID &&
        other.firstPlace == firstPlace &&
        other.secondPlace == secondPlace &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return routeID.hashCode ^ firstPlace.hashCode ^ secondPlace.hashCode ^ duration.hashCode;
  }
}

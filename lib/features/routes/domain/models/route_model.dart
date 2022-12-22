import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:itdols/features/calculation/domain/way_component.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';
import 'package:itdols/features/routes/presentation/simple_route_widget.dart';

class RouteModel extends WayComponent {
  final int id;
  final PlaceModel firstPlace;
  final PlaceModel secondPlace;
  final int duration;

  @override
  Widget toWidget() {
    return SimpleRouteWidget(route: this);
  }

  RouteModel({
    required this.id,
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
    int? id,
    PlaceModel? firstPlace,
    PlaceModel? secondPlace,
    int? duration,
  }) {
    return RouteModel(
      id: id ?? this.id,
      firstPlace: firstPlace ?? this.firstPlace,
      secondPlace: secondPlace ?? this.secondPlace,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_place': firstPlace.toMap(),
      'second_place': secondPlace.toMap(),
      'duration': duration,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      id: map['id'] as int,
      firstPlace: PlaceModel.fromMap(map['first_place'] as Map<String, dynamic>),
      secondPlace: PlaceModel.fromMap(map['second_place'] as Map<String, dynamic>),
      duration: map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) => RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RouteModel(id: $id, firstPlace: $firstPlace, secondPlace: $secondPlace, duration: $duration)';
  }

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstPlace == firstPlace &&
        other.secondPlace == secondPlace &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return id.hashCode ^ firstPlace.hashCode ^ secondPlace.hashCode ^ duration.hashCode;
  }
}

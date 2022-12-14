import 'dart:convert';
import 'package:itdols/features/places/domain/models/place_model.dart';

class RouteModel {
  final PlaceModel firstPlace;
  final PlaceModel secondPlace;
  final int duration;

  RouteModel({
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
    PlaceModel? firstPlace,
    PlaceModel? secondPlace,
    int? duration,
  }) {
    return RouteModel(
      firstPlace: firstPlace ?? this.firstPlace,
      secondPlace: secondPlace ?? this.secondPlace,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstPlace': firstPlace.toMap(),
      'secondPlace': secondPlace.toMap(),
      'duration': duration,
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      firstPlace: PlaceModel.fromMap(map['firstPlace'] as Map<String, dynamic>),
      secondPlace: PlaceModel.fromMap(map['secondPlace'] as Map<String, dynamic>),
      duration: map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) => RouteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RouteModel(firstPlace: $firstPlace, secondPlace: $secondPlace, duration: $duration)';

  @override
  bool operator ==(covariant RouteModel other) {
    if (identical(this, other)) return true;

    return other.firstPlace == firstPlace && other.secondPlace == secondPlace && other.duration == duration;
  }

  @override
  int get hashCode => firstPlace.hashCode ^ secondPlace.hashCode ^ duration.hashCode;
}

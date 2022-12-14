import 'dart:convert';
import 'package:itdols/features/places/domain/models/place_model.dart';

class JobModel {
  final String name;
  final String id;
  final PlaceModel place;
  final int duration;

  String getTimeString() {
    String result = '';
    if (duration >= 60) {
      result = '$resultчасов: ${duration ~/ 60}';
    }
    if (duration % 60 != 0) {
      if (result != '') {
        result = '$result, ';
      }
      result = '$resultминут: ${duration % 60}';
    }
    return result;
  }

  JobModel(
    this.name,
    this.id,
    this.place,
    this.duration,
  );

  JobModel copyWith({
    String? name,
    String? id,
    PlaceModel? place,
    int? duration,
  }) {
    return JobModel(
      name ?? this.name,
      id ?? this.id,
      place ?? this.place,
      duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'place': place.toMap(),
      'duration': duration,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      map['name'] as String,
      map['id'] as String,
      PlaceModel.fromMap(map['place'] as Map<String, dynamic>),
      map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobModel(name: $name, id: $id, place: $place, duration: $duration)';
  }

  @override
  bool operator ==(covariant JobModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id && other.place == place && other.duration == duration;
  }

  @override
  int get hashCode {
    return name.hashCode ^ id.hashCode ^ place.hashCode ^ duration.hashCode;
  }
}

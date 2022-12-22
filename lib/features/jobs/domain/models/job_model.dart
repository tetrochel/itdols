import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:itdols/features/calculation/domain/way_component.dart';
import 'package:itdols/features/jobs/presentation/simple_job_widget.dart';
import 'package:itdols/features/places/domain/models/place_model.dart';

class JobModel extends WayComponent {
  final String name;
  final int id;
  final PlaceModel place;
  final int duration;

  @override
  Widget toWidget() {
    return SimpleJobWidget(job: this);
  }

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

  JobModel(
    this.name,
    this.id,
    this.place,
    this.duration,
  );

  JobModel copyWith({
    String? name,
    int? id,
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
      map['id'] as int,
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

import 'dart:convert';

class PlaceModel {
  final String name;
  final String id;

  PlaceModel(
    this.name,
    this.id,
  );

  PlaceModel copyWith({
    String? name,
    String? id,
  }) {
    return PlaceModel(
      name ?? this.name,
      id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'place_id': id,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      map['name'] as String,
      map['place_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) => PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlaceModel(name: $name, placeID: $id)';

  @override
  bool operator ==(covariant PlaceModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}

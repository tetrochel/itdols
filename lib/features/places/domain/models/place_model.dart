import 'dart:convert';

class PlaceModel {
  final String name;
  final int id;
  final String color;

  PlaceModel(
    this.name,
    this.id,
    this.color,
  );

  PlaceModel copyWith({
    String? name,
    int? id,
    String? color,
  }) {
    return PlaceModel(
      name ?? this.name,
      id ?? this.id,
      color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'color': color,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      map['name'] as String,
      map['id'] as int,
      map['color'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) => PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PlaceModel(name: $name, id: $id, color: $color)';

  @override
  bool operator ==(covariant PlaceModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.id == id &&
      other.color == color;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ color.hashCode;
}

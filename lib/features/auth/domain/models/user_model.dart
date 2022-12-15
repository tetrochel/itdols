import 'dart:convert';

class UserModel {
  final String username;
  final String id;
  UserModel({
    required this.username,
    required this.id,
  });

  UserModel copyWith({
    String? username,
    String? id,
  }) {
    return UserModel(
      username: username ?? this.username,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(username: $username, id: $id)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.id == id;
  }

  @override
  int get hashCode => username.hashCode ^ id.hashCode;
}

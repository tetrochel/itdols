import 'dart:convert';

class UserModel {
  final String username;
  final String token;
  UserModel({
    required this.username,
    required this.token,
  });

  UserModel copyWith({
    String? username,
    String? token,
  }) {
    return UserModel(
      username: username ?? this.username,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(username: $username, token: $token)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username && other.token == token;
  }

  @override
  int get hashCode => username.hashCode ^ token.hashCode;
}

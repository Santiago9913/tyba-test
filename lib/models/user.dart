class User {
  String name;
  String email;
  String uid;

  User({
    required this.name,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'name': name,
        'email': email,
      };

  static User fromJson(Map<String, dynamic> map, String uid) {
    return User(
      name: map['name'],
      email: map['email'],
      uid: uid,
    );
  }
}

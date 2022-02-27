class Restaurant {
  String name;

  Restaurant({
    required this.name,
  });

  Map<String, dynamic> toJSON() => <String, dynamic>{
        'name': name,
      };

  static Restaurant fromJson(Map<String, dynamic> map) {
    return Restaurant(
      name: map['name'],
    );
  }
}

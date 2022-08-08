class User {
  final String name;
  final String age;
  final DateTime dob;

  User({
    required this.name,
    required this.age,
    required this.dob,
  });


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      name: json['name'] ?? 'user name',
      age: json['age'] ?? 0,
      dob: json['dob'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
    'dob': dob,
  };

  User copyWith({
    String? name,
    String? age,
    DateTime? dob,
  }) {
    return User(
      name: name ?? this.name,
      age: age ?? this.age,
      dob: dob ?? this.dob,
    );
  }
}
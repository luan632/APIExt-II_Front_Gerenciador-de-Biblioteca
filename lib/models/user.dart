enum UserType { admin, student }

class User {
  final String id;
  final String name;
  final String email;
  final String registration;
  final UserType type;
  final String? photoUrl;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.registration,
    required this.type,
    this.photoUrl,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      registration: map['registration'],
      type: map['type'] == 'admin' ? UserType.admin : UserType.student,
      photoUrl: map['photoUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'registration': registration,
      'type': type == UserType.admin ? 'admin' : 'student',
      'photoUrl': photoUrl,
    };
  }
}
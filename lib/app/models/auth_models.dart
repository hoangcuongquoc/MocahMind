class AuthModel{
  final String uid;
  final String email;
  final String name;
  final String picture;
  final String bio;

  AuthModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.picture,
    required this.bio,
  });



  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      picture: json['picture'] as String,
      bio: json['bio'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'picture': picture,
      'bio': bio,
    };
  }
}
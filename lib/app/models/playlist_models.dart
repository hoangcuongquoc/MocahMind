class Playlist {
  final int id;
  final String uid;
  final String name;
  final String description;
  final String picture;
  final bool is_pined;

  Playlist({
    required this.id,
    required this.uid,
    required this.name,
    required this.description,
    required this.picture,
    required this.is_pined,
  });


  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'] as int,
      uid: json['uid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String,
      is_pined: json['is_pined'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'description': description,
      'picture': picture,
      'is_pined': is_pined,
    };
  }

}
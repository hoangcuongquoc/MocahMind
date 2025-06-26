class Playlist {
  final int id;
  final String name;
  final String description;
  final String picture;
  final bool isPined;
  final List<String> songIds;
  final String? createdAt;
  final String? userId;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.isPined,
    required this.songIds,
    this.createdAt,
    this.userId,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      picture: json['picture'] ?? '',
      isPined: json['is_pined'] ?? false,
      songIds: List<String>.from(json['song_ids'] ?? []),
      createdAt: json['created_at'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'picture': picture,
      'is_pined': isPined,
      'song_ids': songIds,
      'created_at': createdAt,
      'user_id': userId,
    };
  }
}

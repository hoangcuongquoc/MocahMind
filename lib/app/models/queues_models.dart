class QueuesModel{
  final int id;
  final String uid;
  final String songId;
  final int position;

  QueuesModel({
    required this.id,
    required this.uid,
    required this.songId,
    required this.position,
  });


  factory QueuesModel.fromJson(Map<String, dynamic> json) {
    return QueuesModel(
      id: json['id'] as int,
      uid: json['uid'] as String,
      songId: json['song_id'] as String,
      position: json['position'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'song_id': songId,
      'position': position,
    };
  }
}
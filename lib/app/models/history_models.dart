class HistoryModel {
  final String id;
  final String uid ;
  final String songId;

  HistoryModel({
    required this.id,
    required this.uid,
    required this.songId,
  });
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      songId: json['song_id'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'song_id': songId,
    };
  }
}
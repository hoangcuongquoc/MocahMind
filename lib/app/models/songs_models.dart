class SongsModel {
  final String id;
  final String title;
  final String performer;
  final String image_url;
  final String file_path;
  final String category_id;
  final int views;
  final double duration;

  SongsModel({
    required this.id,
    required this.title,
    required this.performer,
    required this.image_url,
    required this.file_path,
    required this.category_id,
    required this.views,
    required this.duration,
  });

  factory SongsModel.fromJson(Map<String, dynamic> json) {
    return SongsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      performer: json['performer'] ?? '',
      image_url: json['image_url'] ?? '',
      file_path: json['file_path'] ?? '',
      category_id: json['category_id'] ?? '',
      views: json['views'] is int
          ? json['views']
          : int.tryParse('${json['views'] ?? '0'}') ?? 0,
      duration: _parseDuration(json['duration']),
    );
  }

  static double _parseDuration(dynamic value) {
    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'performer': performer,
      'image_url': image_url,
      'file_path': file_path,
      'duration': duration,
      'category_id': category_id,
    };
  }

  String get durationFormatted {
    final d = Duration(seconds: duration.round());
    return '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }
}

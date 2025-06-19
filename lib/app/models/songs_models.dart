class SongsModel{
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

  factory SongsModel.fromJson(Map<String, dynamic>json){
    return SongsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      performer: json['performer'] as String,
      image_url: json['image_url'] as String,
      file_path: json['file_path'] as String,
      category_id: json['category_id'] as String,
      views: json['views'] as int,
      duration: (json['duration'] as num).toDouble(),
    );
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



}
class CategoryModel{
  final String id;
  final String name;
  final String description;
  final String image_url;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image_url,
});

  factory CategoryModel.fromJson(Map<String, dynamic>json){
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      image_url: json['image_url'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': image_url,
    };
  }
}
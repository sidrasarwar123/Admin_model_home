class CategoryModel {
  final String id;
  final String title;
  final String image;
  final int productsCount;
  final String description;
  final String category;
  final List<String> colors;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
    required this.productsCount,
    required this.description,
    required this.category,
    required this.colors,
  });

  factory CategoryModel.fromMap(Map<String, dynamic>? data, String id) {
    if (data == null) {
      // null safe fallback
      return CategoryModel(
        id: id,
        title: '',
        image: '',
        productsCount: 0,
        description: '',
        category: '',
        colors: [],
      );
    }

    return CategoryModel(
      id: id,
      title: data['title']?.toString() ?? '',
      image: data['image']?.toString() ?? '',
      productsCount: data['productsCount'] is int
          ? data['productsCount']
          : int.tryParse(data['productsCount']?.toString() ?? '0') ?? 0,
      description: data['description']?.toString() ?? '',
      category: data['category']?.toString() ?? '',
      colors: data['colors'] != null
          ? List<String>.from(data['colors'])
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'productsCount': productsCount,
      'description': description,
      'category': category,
      'colors': colors,
    };
  }
}

class ProductModel {
  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final List<String> colors;
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    required this.colors,
    required this.image,
  });

  ///  Firestore se data lene ke liye
  factory ProductModel.fromMap(Map<String, dynamic> data, String id) {
    return ProductModel(
      id: id,
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      description: data['description'] ?? '',
      colors: List<String>.from(data['colors'] ?? []),
      image: data['image'] ?? '',
    );
  }

  ///  Firestore me data save karne ke liye
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'price': price,
      'description': description,
      'colors': colors,
      'image': image,
    };
  }

}

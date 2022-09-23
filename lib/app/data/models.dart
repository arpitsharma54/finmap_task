import 'dart:convert';

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List? images;

  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.brand,
    this.category,
    this.discountPercentage,
    this.images,
    this.rating,
    this.stock,
    this.thumbnail,
  });

  factory Products.fromJson(Map<String, dynamic> jsonData) {
    return Products(
      id: jsonData["id"],
      title: jsonData["title"],
      description: jsonData["description"],
      price: jsonData["price"],
      brand: jsonData["brand"],
      category: jsonData["category"],
      discountPercentage: jsonData['discountPercentage'],
      images: jsonData['images'],
      rating: double.parse(jsonData['rating'].toString()),
      stock: jsonData['stock'],
      thumbnail: jsonData['thumbnail'],
    );
  }
}

class Product {
  late final String id;
  late final String name;
  late final String barcode;
  late final double price;
  late final int count;
  late final String imageUrl;
  late final String description;

  Product({
   
    required this.name,
    required this.barcode,
    required this.price,
    required this.count,
    required this.imageUrl,
    required this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
   
    name = json['name'];
    barcode = json['barcode'];
    price = json['price'];
    count = json['count'];
    imageUrl = json['imageUrl'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['name'] = this.name;
    data['barcode'] = this.barcode;
    data['price'] = this.price;
    data['count'] = this.count;
    data['imageUrl'] = this.imageUrl;
    data['description'] = this.description;
    return data;
  }

   Product copyWith({
   
    String? name,
    String? barcode,
    double? price,
    int? count,
    String? imageUrl,
    String? description,
  }) {
    return Product(
     
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
       count: count ?? this.count,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}

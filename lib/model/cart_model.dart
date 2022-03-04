class Cart {
  late final String? id;
  final String? productId;
  final String? name;
  late final int? productPrice;
  final String? image;

  Cart({
    this.id,
    this.productId,
    this.name,
    this.productPrice,
    this.image,
  });
  Cart.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        name = res['name'],
        productPrice = res['productPrice'],
        image = res['image'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'productPrice': productPrice,
      'image': image
    };
  }
}

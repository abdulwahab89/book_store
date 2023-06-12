class BookModel {
  late final int? id;
  late final String? productId;
  late final String? productName;
  late final String? productAuthor;

  late final int? quantity;
  late final int? initialPrice;
  late final int? productPrice;
  late final String? image;
  BookModel({
    required this.id,
    required this.productPrice,
    required this.productName,
    required this.productAuthor,
    required this.quantity,
    required this.initialPrice,
    required this.image,
    required this.productId,
  });
  BookModel.fromMap(Map<dynamic, dynamic> res)
      : id = res['id'],
        productId = res['productId'],
        productName = res['productName'],
        productAuthor = res['productAuthor'],
        productPrice = res['productPrice'],
        initialPrice = res['initialPrice'],
        quantity = res['quantity'],
        image = res['image'];
  Map<String, Object?> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'id': id,
      'initialPrice': initialPrice,
      'productAuthor': productAuthor,
      'quantity': quantity,
      'image': image,
    };
  }
}

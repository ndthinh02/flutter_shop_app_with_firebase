import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  String nameProduct;
  num price;
  num priceOld;
  String image;
  String description;
  num quantity;
  String id;
  num? rateStar;
  num? type;

  Product(
      {required this.nameProduct,
      required this.price,
      required this.image,
      required this.description,
      required this.priceOld,
      required this.quantity,
      this.rateStar,
      this.type,
      required this.id});
}

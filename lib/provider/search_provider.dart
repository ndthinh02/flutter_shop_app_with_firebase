import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/product.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> _mListSearchProduct = [];
  late final List<Product> _newListSearchProduct = _mListSearchProduct;
  getSearchProduct() async {
    List<Product> newList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Product").get();
    for (var element in querySnapshot.docs) {
      Product product = Product(
          nameProduct: element.get("nameProduct"),
          price: element.get("price") ?? 0,
          image: element.get("image"),
          description: element.get("description"),
          priceOld: element.get("priceOld") ?? 0,
          quantity: element.get("quantity") ?? 0,
          id: element.get('idProduct'),
          rateStar: element.get('rateStar'),
          type: element.get('type'));
      newList.add(product);
    }
    _mListSearchProduct = newList;
    print('check query ${_newListSearchProduct.length}');
    notifyListeners();
  }

  searchProduct(String query) {
    if (query.isEmpty) {
      _mListSearchProduct = _newListSearchProduct;
      notifyListeners();
    } else {
      _mListSearchProduct = _newListSearchProduct
          .where((element) =>
              element.nameProduct.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  List<Product> get getListSeacrhProduct => _mListSearchProduct;
}

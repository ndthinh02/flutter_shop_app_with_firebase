import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dialog/dialog.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductProvider extends ChangeNotifier {
  int _quantity = 1;
  int get quantity => _quantity;

  List<Product> _mListProduct = [];
  late List<Product> getListProductByType = _mListProduct;

  void addQuantity() {
    _quantity++;
    notifyListeners();
  }

  void subQuantity() {
    if (quantity == 1) {
      return;
    } else {
      _quantity--;
    }

    notifyListeners();
  }

  void addCart(String name, int quantityy, num price, String image,
      String cartId, BuildContext context) async {
    DialogProvider().showDialogLoading(context);
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourCart')
        .doc(cartId)
        .set({
      "name": name,
      "quantity": quantityy,
      "price": price,
      "image": image,
      "cartId": cartId
    }).whenComplete(() {
      Navigator.of(context).pop();
    }).whenComplete(() => Fluttertoast.showToast(
                msg: "Product is add your cart !",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                fontSize: 16.0)
            .whenComplete(() => _quantity = 0));
    notifyListeners();
  }

  Future<void> fetchDataProduct() async {
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
          id: element.get("idProduct"),
          type: element.get("type") ?? 0,
          rateStar: element.get('rateStar') ?? 0);
      newList.add(product);
    }

    _mListProduct = newList;
    for (var element in _mListProduct) {}
    notifyListeners();
  }

  getProductByType(int type) {
    _mListProduct =
        getListProductByType.where((element) => element.type == type).toList();
    print('check type ${_mListProduct.length}');
    notifyListeners();
  }

  List<Product> get getListProduct => _mListProduct;
}

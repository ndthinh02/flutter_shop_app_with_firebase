import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/dialog/dialog.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:flutter_shop_app/value/loading.dart';
import 'package:flutter_shop_app/value/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../main.dart';

class ProductProvider extends ChangeNotifier {
  int _quantity = 1;
  int get quantity => _quantity;

  List<Product> _mListProduct = [];

  void addQuantity() {
    _quantity++;
    print('heheheehe${quantity}');
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
            fontSize: 16.0));

    notifyListeners();
  }

  Future<void> fetchDataProduct() async {
    List<Product> _newList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Product").get();
    querySnapshot.docs.forEach((element) {
      Product product = Product(
          nameProduct: element.get("nameProduct"),
          price: element.get("price"),
          image: element.get("image"),
          description: element.get("description"),
          priceOld: element.get("priceOld"),
          quantity: element.get("quantity"),
          id: element.get('productId'),
          rateStar: element.get('rateStar'));
      _newList.add(product);
    });
    _newList = _mListProduct;
  }

  List<Product> get getListProduct => _mListProduct;
}

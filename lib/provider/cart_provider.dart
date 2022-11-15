import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/main.dart';
import 'package:flutter_shop_app/model/cart.dart';
import 'package:flutter_shop_app/value/loading.dart';
import 'package:flutter_shop_app/value/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:status_alert/status_alert.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _mListCartModel = [];
  bool isLoading = true;
  final _db = FirebaseFirestore.instance;

  void getDataCart() async {
    isLoading = true;
    List<CartModel> _newList = [];
    QuerySnapshot queryCart = await _db
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCart")
        .get()
        .whenComplete(() => isLoading = false);
    queryCart.docs.forEach((element) {
      // print(element.data());
      CartModel cartModel = CartModel(
        id: element.get("cartId"),
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price") ?? 0,
        quantity: element.get("quantity") ?? 0,
      );
      _newList.add(cartModel);
    });
    print('heheheehehe${_mListCartModel}');
    _mListCartModel = _newList;
    notifyListeners();
  }

  List<CartModel> get getListCart => _mListCartModel;
  Future<void> removeCart(String id, BuildContext context, index) async {
    isLoading = true;

    await _db
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCart")
        .doc(id)
        .delete()
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Product is deleted !",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.black,
            fontSize: 16.0))
        .whenComplete(() => isLoading = false);
    _mListCartModel.removeAt(index);

    notifyListeners();
  }

  double get totalAmount {
    double total = 0;
    _mListCartModel.forEach((element) {
      total = total + (element.price * element.quantity);
      print('fsadfs${total}');
    });
    return total;
  }

  Future<void> addQuantityCart(String productId, num quantity, num price,
      String image, String name) async {
    await _db
        .collection("Cart")
        .doc(UserApp.user.uid)
        .collection("YourCart")
        .doc(productId)
        .set({
      "name": name,
      "quantity": quantity + 1,
      "price": price,
      "image": image,
      "cartId": productId
    });
    notifyListeners();
  }

  void subQuantityCart(
      String productId, num quantity, num price, String image, String name) {
    _db
        .collection("Cart")
        .doc(UserApp.user.uid)
        .collection("YourCart")
        .doc(productId)
        .set({
      "name": name,
      "quantity": quantity - 1,
      "price": price,
      "image": image,
      "cartId": productId
    });

    notifyListeners();
  }
}

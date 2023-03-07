import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/cart.dart';
import 'package:flutter_shop_app/value/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> _mListCartModel = [];
  bool isLoading = true;
  final _db = FirebaseFirestore.instance;

  final CollectionReference productss = FirebaseFirestore.instance
      .collection('Cart')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("YourCart");

  Future getDataCart() async {
    isLoading = true;
    List<CartModel> newList = [];
    QuerySnapshot queryCart = await _db
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCart")
        .get()
        .whenComplete(() => isLoading = false);
    for (var element in queryCart.docs) {
      // print(element.data());
      CartModel cartModel = CartModel(
        id: element.get("cartId"),
        image: element.get("image"),
        name: element.get("name"),
        price: element.get("price") ?? 0,
        quantity: element.get("quantity") ?? 0,
      );
      newList.add(cartModel);
    }

    _mListCartModel = newList;
    notifyListeners();
  }

  List<CartModel> get getListCart => _mListCartModel;
  Future<void> removeCart(String id, int index) async {
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
    for (var element in _mListCartModel) {
      total += element.price * element.quantity;
    }

    return total;
  }

  updateQuantityCart(
      String cartId, num price, String image, String name, num quantity) async {
    // getDataCart();
    await _db
        .collection("Cart")
        .doc(UserApp.user.uid)
        .collection("YourCart")
        .doc(cartId)
        .update({
      "name": name,
      "quantity": quantity,
      "price": price,
      "image": image,
      "cartId": cartId
    });
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavoriteProvider extends ChangeNotifier {
  bool isLoading = true;
  void addProductToFavorite(
      bool isFavorite,
      String name,
      num price,
      String image,
      String idFavorite,
      BuildContext context,
      num priceOld,
      String description,
      num quantity,
      num rateStar) async {
    // DialogProvider().showDialogLoading(context);
    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourFavorite')
        .doc(idFavorite)
        .set({
      "nameFavorite": name,
      // "quantity": quantityy,
      "price": price,
      "image": image,
      "idFavorite": idFavorite,
      "isFavorite": true,
      "priceOld": priceOld,
      "description": description,
      "quantity": quantity,
      "rateStar": rateStar
    });

    notifyListeners();
  }

  void removeFavorite(String idFavorite) {
    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourFavorite")
        .doc(idFavorite)
        .delete()
        .whenComplete(
            () => Fluttertoast.showToast(msg: "Remove succesfully !"));
  }

  List<Product> _listFavortie = [];
  Future<void> getDataFavorite() async {
    isLoading = true;
    List<Product> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourFavorite")
        .get()
        .whenComplete(() => isLoading = false);
    for (var element in querySnapshot.docs) {
      Product product = Product(
        nameProduct: element.get("nameFavorite"),
        price: element.get("price") ?? 0,
        image: element.get("image"),
        description: element.get("description"),
        priceOld: element.get("priceOld"),
        quantity: element.get("quantity"),
        rateStar: element.get("rateStar"),
        id: element.get("idFavorite"),
      );
      newList.add(product);
    }
    _listFavortie = newList;
    notifyListeners();
  }

  List<Product> get getListFavorite => _listFavortie;
}

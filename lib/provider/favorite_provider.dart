import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/model/product.dart';

class FavoriteProvider extends ChangeNotifier {
  bool isLoading = true;
  void addProductToFavorite(bool isFavorite, String name, num price,
      String image, String idFavorite, BuildContext context) async {
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
    });

    notifyListeners();
  }

  void removeFavorite(String idFavorite) {
    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourFavorite")
        .doc(idFavorite)
        .delete();
  }

  List<Product> _listFavortie = [];
  Future<void> getDataFavorite() async {
    isLoading = true;
    List<Product> _newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourFavorite")
        .get()
        .whenComplete(() => isLoading = false);
    querySnapshot.docs.forEach((element) {
      Product product = Product(
          nameProduct: element.get("nameFavorite"),
          price: element.get("price") ?? 0,
          image: element.get("image"),
          description: "",
          priceOld: 2,
          quantity: 1,
          id: element.get("idFavorite"));
      _newList.add(product);
    });
    _listFavortie = _newList;
    print('dksandsjdn${_listFavortie}');
    notifyListeners();
  }

  List<Product> get getListFavorite => _listFavortie;
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../dialog/dialog.dart';
import '../model/user.dart';

class UserProvider extends ChangeNotifier {
  final _picker = ImagePicker();

  File? file;
  UploadTask? uploadTask;
  String? nameImage;
  addUser(String? email, String? urlImage, String? id) {
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "email": email,
      "urlImage": urlImage,
      "id": id,
      "name": "User name",
      "address": "",
      "bio": "Bio",
      "phoneNumber": "",
    });
    notifyListeners();
  }

  addDatabase(
      String nameProduct,
      String price,
      String image,
      String description,
      String priceOld,
      String quantity,
      String type,
      String rateStar) {
    FirebaseFirestore.instance.collection("Product").doc().set({
      'nameProduct': nameProduct,
      'price': num.parse(price),
      'image': nameImage,
      'description': description,
      'priceOld': num.parse(priceOld),
      'quantity': num.parse(quantity),
      'idProduct': DateTime.now().millisecondsSinceEpoch.toString(),
      'type': num.parse(type),
      'rateStar': num.parse(rateStar),
    }).whenComplete(() => Fluttertoast.showToast(msg: 'ok'));
    notifyListeners();
  }

  UserModel? currentUser;
  getUserData() async {
    UserModel? userModel;

    var user = FirebaseAuth.instance.currentUser!;
    var query =
        await FirebaseFirestore.instance.collection("User").doc(user.uid).get();
    if (query.exists) {
      userModel = UserModel(
        name: query['name'],
        email: user.email,
        id: user.uid,
        urlImage: user.photoURL,
        address: query['address'],
        bio: query['bio'],
        phoneNumber: query['phoneNumber'],
      );
    }
    currentUser = userModel;

    notifyListeners();
  }

  updateUser(String email, String id, String name, String address, String bio,
      String phoneNumber, BuildContext context) {
    DialogProvider().showDialogLoading(context);
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          "email": email,
          "id": id,
          "name": name,
          "address": address,
          "bio": bio,
          "phoneNumber": phoneNumber,
          "urlImage": nameImage
        })
        .whenComplete(() => Navigator.of(context).pop())
        .whenComplete(() => Fluttertoast.showToast(
            msg: "Update succesfully!", gravity: ToastGravity.TOP))
        .whenComplete(() => getUserData());
    print('check name in update $nameImage');
    notifyListeners();
  }

  updateAvatarUser(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    nameImage = DateTime.now().millisecondsSinceEpoch.toString();
    final references = FirebaseStorage.instance.ref();
    final imageRef = references.child(nameImage!);
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    file = File(pickedFile!.path);
    notifyListeners();
    uploadTask = imageRef.putFile(file!);
    final snapShop =
        await uploadTask!.whenComplete(() => {Navigator.of(context).pop()});
    nameImage = await snapShop.ref.getDownloadURL();
    uploadTask = null;
    notifyListeners();
  }

  UserModel? get getCurrentUser => currentUser;
}

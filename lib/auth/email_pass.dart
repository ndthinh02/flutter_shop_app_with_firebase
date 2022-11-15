import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/screens/login/login.dart';
import 'package:flutter_shop_app/value/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../dialog/dialog.dart';
import '../main.dart';
import '../screens/my_home_page.dart';

class SignWithEmail {
  Future<void> signInWithEmail(
      String email, String pass, BuildContext context) async {
    DialogProvider().showDialogLoading(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "No found user for email");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong email or password");
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> signUpUser(
      String email, String password, BuildContext context) async {
    DialogProvider().showDialogLoading(context);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => Navigator.of(context).pop());
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: "The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isCurrent);
  }
}

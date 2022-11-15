import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/main.dart';
import 'package:flutter_shop_app/screens/product_screen/cart_screen.dart';
import 'package:flutter_shop_app/screens/bottom_nav/profile_screen.dart';
import 'package:flutter_shop_app/screens/login/login.dart';
import 'package:flutter_shop_app/screens/my_home_page.dart';
import 'package:flutter_shop_app/screens/product_screen/pay_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../dialog/dialog.dart';
import '../provider/product_provider.dart';
import '../ui/color.dart';
import '../ui/text.dart';

class AuthService {
  static var firebaseAuth = FirebaseAuth.instance.currentUser;

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CircularProgressIndicator();
          // }
          if (snapshot.hasData) {
            return MyHomePage(
              title: '',
            );
          } else {
            return const LoginScreen();
          }
        });
  }

  signInWithGoogle(BuildContext context) async {
    DialogProvider().showDialogLoading(context);
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .whenComplete(() => Navigator.of(context).pop())
        .whenComplete(() =>
            navigatorKey.currentState!.popUntil((route) => route.isFirst));
  }

  signOut(BuildContext context) async {
    DialogProvider().showDialogLoading(context);
    await FirebaseAuth.instance.signOut().whenComplete(() =>
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => LoginScreen())));
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  checkUser(BuildContext context) {
    if (firebaseAuth == null) {
      return const Icon(
        Icons.person,
        color: Colors.black,
      );
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
        },
        child: CircleAvatar(
            backgroundImage: NetworkImage(firebaseAuth!.photoURL!)),
      );
    }
  }

  checkUserAfterBuy(BuildContext context, String name, num price, num quantity,
      String image, String productId) {
    if (firebaseAuth == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    } else {
      showModalBottom(name, price, quantity, image, productId, context);
    }
  }

  void showModalBottom(String name, num price, num quantity, String image,
      String productId, BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        builder: ((context) {
          return Consumer<ProductProvider>(builder: ((context, value, child) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 280,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.clear))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(image, width: 100, height: 120),
                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Container(
                                  child: Text(
                                    name,
                                    style: MyTextStyle().subText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$ ${price}'.toString(),
                                style: MyTextStyle().textPrice,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Quantity: ',
                                    style: MyTextStyle().subText,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        value.subQuantity();
                                      },
                                      icon: const Icon(
                                          Icons.remove_circle_outline_rounded)),
                                  Text('${value.quantity}'),
                                  IconButton(
                                      onPressed: () {
                                        value.addQuantity();
                                      },
                                      icon: const Icon(
                                          Icons.add_circle_outline_outlined)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 57,
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: colorMain,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14))),
                              onPressed: () {
                                value.addCart(name, value.quantity, price ?? 0,
                                    image, productId, context);
                                // Navigator.of(context).pop();
                              },
                              child: const Text('Add your cart')),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }));
        }));
  }
}

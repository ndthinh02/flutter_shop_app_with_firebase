import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/auth/email_pass.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/screens/login/register.dart';
import 'package:flutter_shop_app/screens/my_home_page.dart';
import 'package:flutter_shop_app/value/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_service.dart';
import '../../ui/color.dart';
import '../../ui/text.dart';
import '../../ui/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final textEmailController = TextEditingController();
  final textPassWordController = TextEditingController();
  late String email = textEmailController.text;
  late String pass = textPassWordController.text;
  bool isShowPass = true;
  CreateRouter get createRouter => context.read<CreateRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      LottieBuilder.network(
                        ImageURL.urlImageLogin,
                        width: double.infinity,
                        height: 150,
                      ),
                      Text(
                        "Hello Again",
                        style: MyTextStyle().textTitileLogin,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 200,
                        child: Text(
                          "Welcome back you're been missed",
                          style: MyTextStyle().textSubLogin,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextInput(
                        textInputType: TextInputType.emailAddress,
                        faIcon: 'images/email.png',
                        textEditingController: textEmailController,
                        hintText: 'Email',
                        isShowPass: false,
                      ),
                      TextInput(
                        faIcon: 'images/lock.png',
                        textEditingController: textPassWordController,
                        hintText: 'Password',
                        isShowPass: isShowPass,
                        iconButton: IconButton(
                            onPressed: () {
                              setState(() {
                                isShowPass = !isShowPass;
                                print('onsadnasdns${isShowPass}');
                              });
                            },
                            icon: Icon(
                              isShowPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: colorGreen,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Forgot your password ?',
                              style: MyTextStyle().textForgotPass,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                          height: 50,
                          margin: const EdgeInsets.only(
                              bottom: 40, right: 40, left: 40),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (textEmailController.text.isEmpty ||
                                  textPassWordController.text.isEmpty) {
                                Fluttertoast.showToast(msg: 'Khong dc torng');
                              } else if (!EmailValidator.validate(
                                  textEmailController.text, true)) {
                                Fluttertoast.showToast(
                                    msg: 'Email nhu cai con caac');
                              } else {
                                SignWithEmail().signInWithEmail(
                                    textEmailController.text.trim(),
                                    textPassWordController.text.trim(),
                                    context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: colorMain,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14))),
                            child: Text(
                              'Login',
                              style: MyTextStyle().textButton,
                            ),
                          )),
                      const Text(
                          '- - - - - - - - - - - - - - - - - - - -  OR - - - - - - - - - - - - - - - - - - -'),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                AuthService().signInWithGoogle(context);
                              },
                              child: const Image(
                                image: AssetImage('images/goolge.png'),
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: const Image(
                                image: AssetImage('images/fb.png'),
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: const Image(
                                image: AssetImage('images/apple.png'),
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Not a Member ? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(createRouter.createRouteRegisterPage());
                      },
                      child: const Text('Register here ',
                          style: TextStyle(
                              color: colorMain, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    textEmailController.dispose();
    textPassWordController.dispose();
    super.dispose();
  }
}

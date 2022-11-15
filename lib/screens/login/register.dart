import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_app/auth/email_pass.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:flutter_shop_app/ui/text.dart';
import 'package:flutter_shop_app/ui/text_input.dart';
import 'package:flutter_shop_app/value/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final textEmailController = TextEditingController();
  final textPassWordController = TextEditingController();
  final textRePassController = TextEditingController();
  bool isShowPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.network(
              ImageURL.urlImageRegister,
              width: double.infinity,
              height: 230,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      "Let's get started",
                      maxLines: 2,
                      style: MyTextStyle().textMainRegister,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Create Account",
                    style: MyTextStyle().textSubRegister,
                  ),
                  TextInput(
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
                          });
                        },
                        icon: Icon(isShowPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: colorGreen),
                  ),
                  TextInput(
                    faIcon: 'images/lock.png',
                    textEditingController: textRePassController,
                    hintText: 'Re password',
                    isShowPass: isShowPass,
                    iconButton: IconButton(
                        onPressed: () {
                          setState(() {
                            isShowPass = !isShowPass;
                          });
                        },
                        icon: Icon(isShowPass
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: colorGreen),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(40),
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorMain,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))),
                  onPressed: () {
                    if (textEmailController.text.isEmpty ||
                        textPassWordController.text.isEmpty ||
                        textRePassController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'The fill is not empty! ');
                    } else if (!EmailValidator.validate(
                        textEmailController.text, true)) {
                      Fluttertoast.showToast(msg: 'Invalid email');
                    } else if (textPassWordController.text !=
                        textRePassController.text) {
                      Fluttertoast.showToast(
                          msg: 'Password and repassword must overlap');
                    } else {
                      SignWithEmail().signUpUser(textEmailController.text,
                          textPassWordController.text, context);
                    }
                  },
                  child: Text(
                    'Register',
                    style: MyTextStyle().textButton,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

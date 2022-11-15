import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_app/auth/auth_service.dart';
import 'package:flutter_shop_app/screens/my_home_page.dart';
import 'package:lottie/lottie.dart';

import '../ui/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (ctx) => AuthService().handleAuthState()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMain,
      body: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Image(image: AssetImage('images/logo.png')),
            LottieBuilder.network(
              'https://assets6.lottiefiles.com/packages/lf20_p8bfn5to.json',
              width: 100,
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

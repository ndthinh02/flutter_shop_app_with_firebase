import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/ui/text.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../widget/home_screen/banner.dart';
import '../../widget/home_screen/best_seller.dart';

class HomeScreen extends StatefulWidget {
  Product? product;
  HomeScreen({super.key, required this.title, this.product});

  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  CreateRouter get createRouterProvider => context.read<CreateRouter>();

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40));
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                const SizedBox(width: 10),
                Text(
                  'Ha Noi - Viet Nam',
                  style: MyTextStyle().textAppbar,
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(createRouterProvider.createRouteCartScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )))
          ],
        ),
        backgroundColor: const Color(0xFFF8F8F8),
        body: Container(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LottieBuilder.network(
                    'https://assets1.lottiefiles.com/packages/lf20_puciaact.json'),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Hot Sales',
                      style: MyTextStyle().titleText,
                    ),
                  ],
                ),
                const BannerHomePage(),
                const BestSeller(),
              ],
            ),
          ),
        ));
  }
}

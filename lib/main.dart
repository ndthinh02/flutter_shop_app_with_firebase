import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/banner_provider.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/provider/category_provider.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/provider/delivery_details_provider.dart';
import 'package:flutter_shop_app/provider/favorite_provider.dart';
import 'package:flutter_shop_app/provider/product_provider.dart';
import 'package:flutter_shop_app/provider/search_provider.dart';
import 'package:flutter_shop_app/provider/user_provider.dart';
import 'package:flutter_shop_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'model/category.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "FlutterShopApp",
    options: const FirebaseOptions(
      apiKey: "AIzaSyCViXrKVJsHSI6o09Iv4N2VyfOl_mg3alY",
      appId: "1:714798739680:android:e593433cccf755b4cba085",
      messagingSenderId: "XXX",
      projectId: "fluttershopapp-e5a1f",
    ),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
    ChangeNotifierProvider(
      create: (ctx) => CategoryProduct(icon: Icons.cabin, name: ''),
    ),
    ChangeNotifierProvider(
      create: (ctx) => BannerProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => ProductProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => CreateRouter(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => FavoriteProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => SearchProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (ctx) => DeliveryDetailsProvider(),
    ),
  ], child: const MyApp()));
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}

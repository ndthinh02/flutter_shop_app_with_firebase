import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/auth/auth_service.dart';
import 'package:flutter_shop_app/model/category.dart';
import 'package:flutter_shop_app/provider/category_provider.dart';
import 'package:flutter_shop_app/provider/product_provider.dart';
import 'package:flutter_shop_app/screens/bottom_nav/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../ui/color.dart';
import 'product_screen/cart_screen.dart';
import 'bottom_nav/favorite_screen.dart';
import 'bottom_nav/profile_screen.dart';
import 'bottom_nav/search_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CategoryProvider get categoryProvider => context.read<CategoryProvider>();
  CategoryProduct get read => context.read<CategoryProduct>();
  CategoryProduct get watch => context.watch<CategoryProduct>();
  ProductProvider get productProvider => context.read<ProductProvider>();
  int pageIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // productProvider.getProductData();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(40));
    List<Widget> _widgetOption = <Widget>[
      HomeScreen(title: ''),
      const SearchScreen(),
      const FavoriteScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: _widgetOption.elementAt(pageIndex),
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
        height: 60,
        decoration: const BoxDecoration(
          color: colorMain,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.grey[100]!,
            color: Colors.black,
            // ignore: prefer_const_literals_to_create_immutables
            tabs: [
              const GButton(
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              const GButton(
                icon: Icons.search_outlined,
                text: 'Search',
              ),
              const GButton(
                icon: (Icons.favorite_outline),
                text: 'Favorite',
              ),
              const GButton(
                icon: (Icons.person_outline_outlined),
                text: 'Profile',
              ),
            ],
            selectedIndex: pageIndex,
            onTabChange: (index) {
              setState(() {
                pageIndex = index;
              });
            },
          ),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/product_provider.dart';
import 'package:flutter_shop_app/widget/detail_screen/content.dart';
import 'package:provider/provider.dart';

import '../../model/product.dart';
import '../../provider/create_router.dart';
import '../../ui/text.dart';
import '../../widget/detail_screen/bottom.dart';

class DetailScreen extends StatefulWidget {
  Product product;
  DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedColor = 0;
  int selectedCapacity = 0;
  ProductProvider get productProvier => context.read<ProductProvider>();
  ProductProvider get watchProductProvier => context.watch<ProductProvider>();
  CreateRouter get createRouterProvider => context.read<CreateRouter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        title: Text(
          widget.product.nameProduct,
          style: MyTextStyle().textAppbar,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(createRouterProvider.createRouteCartScreen());
              },
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(child: Content(product: widget.product)),
            ),
          ),
          Bottom(product: widget.product)
        ],
      ),
    );
  }
}

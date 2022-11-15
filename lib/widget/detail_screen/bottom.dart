import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_service.dart';
import '../../provider/product_provider.dart';
import '../../ui/color.dart';
import '../../ui/text.dart';

class Bottom extends StatefulWidget {
  DocumentSnapshot product;
  Bottom({super.key, required this.product});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  ProductProvider get productProvier => context.read<ProductProvider>();
  ProductProvider get watchProductProvier => context.watch<ProductProvider>();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: colorMain),
              onPressed: () {
                AuthService().checkUserAfterBuy(
                    context,
                    widget.product['nameProduct'],
                    widget.product['price'],
                    productProvier.quantity,
                    widget.product['image'],
                    widget.product['productId']);
              },
              child: GestureDetector(
                child: Text(
                  'Add to cart',
                  style: MyTextStyle().textAddcart,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.green),
              onPressed: () {},
              child: Text(
                'Buy Now',
                style: MyTextStyle().textAddcart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

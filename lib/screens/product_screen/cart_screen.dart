import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/cart.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/provider/product_provider.dart';

import 'package:provider/provider.dart';
import 'package:status_alert/status_alert.dart';

import '../../ui/color.dart';
import '../../ui/text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // DocumentReference documentReference = FirebaseFirestore.instance
  //     .collection("Cart")
  //     .doc(FirebaseAuth.instance.currentUser!.uid)
  //     .collection("YourCart")
  //     .doc();

  CartProvider get readCartProver => context.read<CartProvider>();
  CartProvider get watchCartProver => context.watch<CartProvider>();

  ProductProvider get productProvider => context.read<ProductProvider>();
  String description =
      "A smartphone is a cell phone that allows you to do more than make phone calls and send text messages. Smartphones can browse the Internet and run software programs like a computer. Smartphones use a touch screen to allow users to interact with them.";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCartProver.getDataCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Your cart', style: MyTextStyle().textAppbar),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:
                const Icon(Icons.arrow_back_ios_new_rounded, color: colorBlack),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<CartProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (value.getListCart.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Product in your cart',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: watchCartProver.getListCart.length,
                      itemBuilder: ((context, index) {
                        CartModel data = watchCartProver.getListCart[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Dismissible(
                                  key: ValueKey(data.id),
                                  onDismissed: ((direction) {
                                    readCartProver.removeCart(
                                        data.id, context, index);
                                  }),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Theme.of(context).errorColor,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 4,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ),
                                  child: _buildContent(data)),
                            ],
                          ),
                        );
                      }));
                },
              ),
            ),
          ],
        ));
  }

  Widget _buildContent(CartModel data) {
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              data.image,
              width: 100,
              height: 100,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    child: Container(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(data.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: MyTextStyle().subText),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 200,
                            child: Text(
                              description,
                              style: MyTextStyle().subTextCartScreen,
                              maxLines: 3,
                            ),
                          ),
                          Expanded(child: _buildQuantity(data)),
                          Text(
                            'Total: ${data.quantity * data.price}',
                            style: MyTextStyle().textPriceTotal,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 14,
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        )
      ],
    );
  }

  Widget _buildQuantity(CartModel data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('\$${data.price.toString()}',
            style: MyTextStyle().textPriceDetail),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  readCartProver.subQuantityCart(data.id, data.quantity,
                      data.price, data.image, data.name);
                },
                icon: const Icon(Icons.remove_circle_outline_rounded)),
            Text('${data.quantity}'),
            IconButton(
                onPressed: () {
                  readCartProver.addQuantityCart(data.id, data.quantity,
                      data.price, data.image, data.name);
                },
                icon: const Icon(Icons.add_circle_outline_outlined)),
          ],
        ),
      ],
    );
  }
}

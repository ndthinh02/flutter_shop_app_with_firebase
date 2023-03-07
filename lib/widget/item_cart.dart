import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';
import '../ui/text.dart';

class CartItem extends StatefulWidget {
  String id;
  String image;
  String name;
  num price;
  num quantity;
  int index;
  CartItem(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.index});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartProvider get readCartProver => context.read<CartProvider>();
  CartProvider get watchCartProver => context.watch<CartProvider>();

  ProductProvider get productProvider => context.read<ProductProvider>();
  num quantity = 1;
  String description =
      "A smartphone is a cell phone that allows you to do more than make phone calls and send text messages. Smartphones can browse the Internet and run software programs like a computer. Smartphones use a touch screen to allow users to interact with them.";
  getQuantity() {
    FirebaseFirestore.instance
        .collection("Cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourCart")
        .doc(widget.id)
        .get()
        .then((value) => {
              if (mounted)
                {
                  setState(() {
                    quantity = value.get("quantity");
                  })
                }
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuantity();
    readCartProver.getDataCart();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Dismissible(
                key: ValueKey(widget.id),
                onDismissed: ((direction) {
                  readCartProver.removeCart(widget.id, widget.index);
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
                child: _buildContent()),
          ],
        ),
      );
    });
  }

  Widget _buildContent() {
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              widget.image,
              width: 100,
              height: 100,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 5),
                    child: SizedBox(
                      height: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 180,
                            child: Text(widget.name,
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
                          Expanded(child: _buildQuantity()),
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
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$ ${widget.price}', style: MyTextStyle().textPriceDetail),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    if (quantity <= 1) {
                      return;
                    } else {
                      setState(() {
                        quantity--;
                      });
                      readCartProver.getDataCart();
                      readCartProver.updateQuantityCart(widget.id, widget.price,
                          widget.image, widget.name, quantity);
                    }
                  },
                  icon: const Icon(Icons.remove, size: 14)),
              Column(
                children: [
                  const SizedBox(height: 17),
                  Text('$quantity'),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    setState(() {
                      quantity++;
                    });
                    readCartProver.getDataCart();
                    readCartProver.updateQuantityCart(widget.id, widget.price,
                        widget.image, widget.name, quantity);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 14,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

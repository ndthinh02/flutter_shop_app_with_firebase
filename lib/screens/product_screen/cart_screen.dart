import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/provider/product_provider.dart';
import 'package:flutter_shop_app/widget/item_cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../ui/color.dart';
import '../../ui/text.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0;

  CartProvider get readCartProver => context.read<CartProvider>();
  CartProvider get watchCartProver => context.watch<CartProvider>();
  CartProvider? cartProvider;
  ProductProvider get productProvider => context.read<ProductProvider>();
  CreateRouter get createRouter => context.read<CreateRouter>();

  String description =
      "A smartphone is a cell phone that allows you to do more than make phone calls and send text messages. Smartphones can browse the Internet and run software programs like a computer. Smartphones use a touch screen to allow users to interact with them.";
  var priceFormat = NumberFormat('#,##,000');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCartProver.getDataCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ListTile(
          title: const Text("Total Amount"),
          subtitle: Text(
            "\$ ${watchCartProver.totalAmount}",
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          trailing: SizedBox(
            width: 160,
            child: MaterialButton(
              color: colorMain,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              onPressed: () {
                if (readCartProver.getListCart.isEmpty) {
                  Fluttertoast.showToast(msg: 'You must have items');
                } else {
                  Navigator.of(context)
                      .push(createRouter.createRouteDeliveryAddress());
                }
              },
              child: const Text("Confirm"),
            ),
          ),
        ),
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
        ),
        body: Column(
          children: [
            Expanded(
                child: Consumer<CartProvider>(builder: (context, value, child) {
              if (value.getListCart.isEmpty) {
                return const Center(
                  child: Text("No product in your cart"),
                );
              }
              return ListView.builder(
                  itemCount: value.getListCart.length,
                  itemBuilder: ((context, index) {
                    final items = value.getListCart[index];
                    return CartItem(
                        id: items.id,
                        image: items.image,
                        name: items.name,
                        price: items.price,
                        quantity: items.quantity,
                        index: index);
                  }));
            })),
          ],
        ));
  }
}

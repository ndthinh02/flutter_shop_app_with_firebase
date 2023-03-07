import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/cart_provider.dart';
import 'package:flutter_shop_app/provider/delivery_details_provider.dart';
import 'package:flutter_shop_app/screens/checkout/payment/order_item.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:provider/provider.dart';

import '../../../ui/text.dart';

class PaymentScreen extends StatefulWidget {
  String name;
  String phoneNumber;
  String address;
  String addressType;

  PaymentScreen(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.address,
      required this.addressType});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

enum AddressType { home, onlinePayment }

class _PaymentScreenState extends State<PaymentScreen> {
  CartProvider get cartProvider => context.read<CartProvider>();
  DeliveryDetailsProvider get deliveryDetailsProvider =>
      context.read<DeliveryDetailsProvider>();
  var myType = AddressType.home;

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartProvider.totalAmount;
    return Scaffold(
        bottomNavigationBar: ListTile(
          title: const Text("Total Amount"),
          subtitle: Text(
            '\$ ${totalPrice + 10 - 30}',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          trailing: SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () {
                deliveryDetailsProvider.addPlaceOderData(
                    oderItemList: cartProvider.getListCart,
                    subTotal: cartProvider.totalAmount,
                    context,
                    widget.name,
                    widget.address,
                    widget.phoneNumber);
                deliveryDetailsProvider.deleteAllCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorMain,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Pleace Order",
                style: TextStyle(
                  color: colorBlack,
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Payment summary', style: MyTextStyle().textAppbar),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:
                const Icon(Icons.arrow_back_ios_new_rounded, color: colorMain),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.name),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          padding: const EdgeInsets.all(1),
                          height: 20,
                          decoration: BoxDecoration(
                              color: colorMain,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              widget.addressType,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                leading: const CircleAvatar(
                  radius: 8,
                  backgroundColor: colorMain,
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.address),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(widget.phoneNumber),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ExpansionTile(
                  title: Text('Order Item ${cartProvider.getListCart.length}'),
                  children: cartProvider.getListCart
                      .map((e) => OrderItem(e: e))
                      .toList()),
              const Divider(),
              ListTile(
                minVerticalPadding: 5,
                leading: const Text(
                  "Sub Total",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "\$ $totalPrice",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  "Shipping Charge",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: const Text(
                  "\$ ${10}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                minVerticalPadding: 5,
                leading: Text(
                  "Compen Discount",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: const Text(
                  "\$30",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(),
              const ListTile(
                leading: Text("Payment Options"),
              ),
              RadioListTile(
                value: AddressType.home,
                groupValue: myType,
                title: const Text("Home"),
                onChanged: (value) {
                  setState(() {
                    myType = value!;
                  });
                },
                secondary: const Icon(
                  Icons.work,
                  color: colorGreen,
                ),
              ),
              RadioListTile(
                value: AddressType.onlinePayment,
                groupValue: myType,
                title: const Text("OnlinePayment"),
                onChanged: (value) {
                  setState(() {
                    myType = value!;
                  });
                },
                secondary: const Icon(
                  Icons.devices_other,
                  color: colorGreen,
                ),
              )
            ],
          ),
        ));
  }
}

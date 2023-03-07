import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/checkout/payment/payment_screen.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:provider/provider.dart';

import '../../../provider/delivery_details_provider.dart';

class ItemDeliveryDetail extends StatefulWidget {
  final String? title;
  final String? address;
  final String? number;
  final String? addressType;
  final String? id;
  final int? index;
  const ItemDeliveryDetail(
      {this.title,
      this.addressType,
      this.address,
      this.number,
      this.id,
      this.index});

  @override
  State<ItemDeliveryDetail> createState() => _ItemDeliveryDetailState();
}

class _ItemDeliveryDetailState extends State<ItemDeliveryDetail> {
  DeliveryDetailsProvider get deliveryDetailsProvider =>
      context.read<DeliveryDetailsProvider>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => PaymentScreen(
                      name: widget.title!,
                      phoneNumber: widget.number!,
                      address: widget.address!,
                      addressType: widget.addressType!,
                    ))));
          },
          child: Dismissible(
            key: ValueKey(widget.id),
            onDismissed: ((direction) {
              deliveryDetailsProvider.removeDeliveryAddress(
                  widget.id!, widget.index!, context);
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
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title!),
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
                            widget.addressType!,
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
                  Text(widget.address!),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(widget.number!),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          height: 35,
        ),
      ],
    );
  }
}

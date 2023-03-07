import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/checkout/delivery/add_delivery.dart';
import 'package:flutter_shop_app/screens/checkout/delivery/item_delivery_detail.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:provider/provider.dart';

import '../../../provider/delivery_details_provider.dart';
import '../../../ui/text.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({super.key});
  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  DeliveryDetailsProvider get deliveryDetailsProvider =>
      context.read<DeliveryDetailsProvider>();
  DeliveryDetailsProvider get watchDeliveryDetailsProvider =>
      context.watch<DeliveryDetailsProvider>();
  @override
  Widget build(BuildContext context) {
    deliveryDetailsProvider.getDeliveryAddressData();
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Delivery detail',
            style: MyTextStyle().textAppbar,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: colorMain,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddDeliverAddress()));
            },
            child: const Text("Add new address"),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text("Delivery to"),
                      leading: Image.network(
                        'https://th.bing.com/th/id/OIP.5KMbZ6zuY12vIhOnicICxQAAAA?pid=ImgDet&w=195&h=278&c=7&dpr=1.1',
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    watchDeliveryDetailsProvider.getListDeliveryAddres.isEmpty
                        ? const Center(
                            child: Text('No address'),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: watchDeliveryDetailsProvider
                                .getListDeliveryAddres.length,
                            itemBuilder: ((context, index) {
                              final items = deliveryDetailsProvider
                                  .getListDeliveryAddres[index];
                              return ItemDeliveryDetail(
                                index: index,
                                id: items.id,
                                title: items.firstName! + items.lastName!,
                                address: items.street,
                                number: items.phoneNumber,
                                addressType: items.addressType ==
                                        "AddressTypes.Home"
                                    ? "Home"
                                    : items.addressType == "AddressTypes.Other"
                                        ? "Other"
                                        : "Work",
                              );
                            }))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

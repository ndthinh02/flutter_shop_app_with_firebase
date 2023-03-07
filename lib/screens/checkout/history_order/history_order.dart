import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/delivery_details_provider.dart';
import 'package:flutter_shop_app/screens/checkout/history_order/detail_history_order.dart';
import 'package:provider/provider.dart';

import '../../../ui/color.dart';
import '../../../ui/text.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({super.key});

  @override
  State<HistoryOrderScreen> createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  DeliveryDetailsProvider get deliveryDetailsProvider =>
      context.read<DeliveryDetailsProvider>();
  DeliveryDetailsProvider get watchDeliveryDetailsProvider =>
      context.watch<DeliveryDetailsProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deliveryDetailsProvider.getOrderItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('My order', style: MyTextStyle().textAppbar),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:
                const Icon(Icons.arrow_back_ios_new_rounded, color: colorMain),
          ),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: watchDeliveryDetailsProvider.getListHistoryOrder.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => DetailHistoryOrder(
                              historyOrder: deliveryDetailsProvider
                                  .getListHistoryOrder[index],
                            ))));
                  },
                  child: Column(
                    children: [
                      ListTile(title: Text('History Order ${index + 1}')),
                      const Divider(
                        height: 1,
                        color: Colors.grey,
                      )
                    ],
                  ));
            },
          ),
        ));
  }
}

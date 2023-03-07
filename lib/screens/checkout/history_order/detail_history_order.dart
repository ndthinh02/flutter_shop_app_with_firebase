import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/history_order.dart';

import '../../../ui/color.dart';
import '../../../ui/text.dart';

class DetailHistoryOrder extends StatelessWidget {
  HistoryOrder historyOrder;
  DetailHistoryOrder({super.key, required this.historyOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Detail History Order', style: MyTextStyle().textAppbar),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon:
                const Icon(Icons.arrow_back_ios_new_rounded, color: colorMain),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: historyOrder.orderItem.length,
                itemBuilder: ((context, index) {
                  final items = historyOrder.orderItem[index];
                  Timestamp stamp = items['orderTime'];
                  DateTime date = stamp.toDate();
                  return ListTile(
                    title: Text(items['orderName']),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Quantity: ${items['orderQuantity']}'),
                            const SizedBox(
                              width: 30,
                            ),
                            Text('Price: ${items['orderPrice']}'),
                          ],
                        ),
                        Text('Time order: $date'),
                      ],
                    ),
                    leading: Image.network(
                        historyOrder.orderItem[index]['orderImage']),
                  );
                }))));
  }
}

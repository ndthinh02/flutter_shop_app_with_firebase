import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../provider/create_router.dart';
import '../ui/text.dart';

class GridItem extends StatefulWidget {
  AsyncSnapshot snapshot;
  GridItem({super.key, required this.snapshot});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  CreateRouter get createRouterProvider => context.read<CreateRouter>();
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisExtent: 200,
          childAspectRatio: 3 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: widget.snapshot.data!.docs.length,
      itemBuilder: ((context, index) {
        final DocumentSnapshot documentSnapshot =
            widget.snapshot.data!.docs[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                createRouterProvider.createRouteDetailScreen(documentSnapshot));
          },
          child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.network(
                      documentSnapshot['image'],
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      documentSnapshot['nameProduct'],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: MyTextStyle().subText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: MyTextStyle().textPrice,
                            ),
                            Text(
                              documentSnapshot['price'].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyle().textPrice,
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: MyTextStyle().textPriceOld,
                            ),
                            Text(
                              documentSnapshot['priceOld'].toString(),
                              overflow: TextOverflow.ellipsis,
                              style: MyTextStyle().textPriceOld,
                            ),
                          ],
                        ),
                        // Text(documentSnapshot['priceOld']),
                      ],
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }
}

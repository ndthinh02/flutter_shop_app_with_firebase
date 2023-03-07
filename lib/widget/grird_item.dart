import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:provider/provider.dart';

import '../provider/create_router.dart';
import '../provider/product_provider.dart';
import '../ui/text.dart';

class GridItem extends StatefulWidget {
  Product product;
  GridItem({super.key, required this.product});

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  CreateRouter get createRouterProvider => context.read<CreateRouter>();
  ProductProvider get productProvider => context.read<ProductProvider>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(createRouterProvider.createRouteDetailScreen(widget.product));
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
                  widget.product.image,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.product.nameProduct,
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
                          widget.product.price.toString(),
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
                          widget.product.priceOld.toString(),
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
  }
}

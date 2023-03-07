import 'package:flutter/material.dart';
import 'package:flutter_shop_app/model/product.dart';
import 'package:provider/provider.dart';

import '../provider/create_router.dart';
import '../provider/favorite_provider.dart';
import '../screens/product_screen/detail_screen.dart';

class FavoriteItem extends StatefulWidget {
  Product product;
  FavoriteItem({super.key, required this.product});

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  CreateRouter get createRouterProvider => context.read<CreateRouter>();
  FavoriteProvider get readFavorite => context.read<FavoriteProvider>();
  FavoriteProvider get watchdFavorite => context.read<FavoriteProvider>();

  @override
  Widget build(BuildContext context) {
    // getFavoriteListBool();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailScreen(product: widget.product),
        ));
      },
      child: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          ListTile(
            trailing: IconButton(
              onPressed: () {
                readFavorite.getDataFavorite();
                readFavorite.removeFavorite(widget.product.id);
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
              ),
            ),
            leading: Image.network(widget.product.image),
            title: SizedBox(
              width: 140,
              child: Text(
                widget.product.nameProduct,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            margin: const EdgeInsets.only(left: 14, right: 14),
            width: double.infinity,
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

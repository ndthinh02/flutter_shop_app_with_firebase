import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/favorite_provider.dart';
import 'package:flutter_shop_app/ui/text.dart';
import 'package:flutter_shop_app/widget/item_favorite.dart';
import 'package:provider/provider.dart';

import '../../provider/create_router.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  CreateRouter get createRouterProvider => context.read<CreateRouter>();
  FavoriteProvider get readFavorite => context.read<FavoriteProvider>();
  FavoriteProvider get watchdFavorite => context.read<FavoriteProvider>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readFavorite.getDataFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Container(
                margin: const EdgeInsets.only(right: 5),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(createRouterProvider.createRouteCartScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )))
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Your favorite',
            style: MyTextStyle().textAppbar,
          ),
        ),
        body: Consumer<FavoriteProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const CircularProgressIndicator();
            }
            if (value.getListFavorite.isEmpty) {
              return const Center(child: Text('No Favorite'));
            }
            return ListView.builder(
              itemCount: readFavorite.getListFavorite.length,
              itemBuilder: (context, index) {
                final data = watchdFavorite.getListFavorite[index];

                return FavoriteItem(
                  product: data,
                );
              },
            );
          },
        ));
  }
}

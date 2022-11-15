import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_app/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../provider/product_provider.dart';
import '../../ui/text.dart';

class Content extends StatefulWidget {
  DocumentSnapshot product;
  Content({super.key, required this.product});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  int selectedColor = 0;
  int selectedCapacity = 0;
  bool _isFavorite = false;
  FavoriteProvider get readFavorite => context.read<FavoriteProvider>();
  getFavoriteListBool() {
    FirebaseFirestore.instance
        .collection("Favorite")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("YourFavorite")
        .doc(widget.product.id)
        .get()
        .then((value) => {
              if (mounted)
                {
                  setState(() {
                    _isFavorite = value.get("isFavorite");
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getFavoriteListBool();
    String description = widget.product['description'];
    return Column(
      children: [
        Image.network(widget.product['image']),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, -15),
                    blurRadius: 20,
                    color: const Color(0xFFDADADA).withOpacity(0.30))
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product['nameProduct'],
                  style: MyTextStyle().titleText,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "\$ ${widget.product['price']}",
                      style: MyTextStyle().textPriceDetail,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _isFavorite = !_isFavorite;

                            if (_isFavorite == true) {
                              readFavorite.addProductToFavorite(
                                  _isFavorite,
                                  widget.product['nameProduct'],
                                  widget.product['price'],
                                  widget.product['image'],
                                  widget.product['productId'],
                                  context);
                            } else {
                              readFavorite
                                  .removeFavorite(widget.product['productId']);
                            }
                          });
                        },
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        )),
                    const SizedBox(width: 10),
                    GestureDetector(
                      child: const Image(
                        image: AssetImage('images/share.png'),
                        width: 20,
                        height: 20,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      child: const Image(
                        image: AssetImage('images/message.png'),
                        width: 30,
                        height: 30,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Wrap(
                      children: List.generate(
                          widget.product['rateStar'],
                          (index) => const Icon(
                                Icons.star,
                                size: 14,
                                color: Color.fromARGB(255, 254, 124, 3),
                              )),
                    ),
                    const SizedBox(width: 10),
                    const Text('1220 review')
                  ],
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                    child: ReadMoreText(
                  description,
                  trimLines: 5,
                  lessStyle: const TextStyle(color: Colors.green),
                  moreStyle: const TextStyle(color: Colors.red),
                  trimCollapsedText: '..Show More',
                  trimExpandedText: '...Show Less',
                  trimMode: TrimMode.Line,
                )),
                const SizedBox(height: 10),
                Text(
                  'Select color and capacity',
                  style: MyTextStyle().subText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColor = index;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: index == 0
                                        ? Colors.red
                                        : index == 1
                                            ? Colors.green
                                            : Colors.amber,
                                    child: selectedColor == index
                                        ? const Icon(
                                            Icons.check,
                                            size: 14,
                                          )
                                        : Container(),
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

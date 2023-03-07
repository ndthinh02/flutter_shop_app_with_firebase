import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widget/grird_item.dart';
import 'package:provider/provider.dart';

import '../../model/category.dart';
import '../../provider/category_provider.dart';
import '../../provider/create_router.dart';
import '../../provider/product_provider.dart';
import '../../ui/color.dart';
import '../../ui/text.dart';
import 'category.dart';

class BestSeller extends StatefulWidget {
  const BestSeller({super.key});

  @override
  State<BestSeller> createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  // final CollectionReference product =
  //     FirebaseFirestore.instance.collection('Product');
  // ProductProvider get read => context.read<ProductProvider>();

  CategoryProvider get categoryProvider => context.read<CategoryProvider>();
  CategoryProduct get readCategory => context.read<CategoryProduct>();
  CategoryProduct get watch => context.watch<CategoryProduct>();
  ProductProvider get productProvider => context.read<ProductProvider>();
  CreateRouter get createRouterProvider => context.read<CreateRouter>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productProvider.fetchDataProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Category',
                style: MyTextStyle().titleText,
              )
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    categoryProvider.mListCategory.length,
                    (index) => Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            readCategory.changeColorSelected(index);
                            productProvider.getProductByType(index);
                          },
                          child: CategoryWidget(
                            color: watch.selectedIndex == index
                                ? colorMain
                                : Colors.white,
                            circleAvatar:
                                categoryProvider.mListCategory[index].icon,
                            text: categoryProvider.mListCategory[index].name,
                            onPress: () {},
                            colorText: watch.selectedIndex == index
                                ? colorMain
                                : Colors.black,
                          ),
                        ))),
              )),
          const SizedBox(height: 10),
          Consumer<ProductProvider>(
            builder: (context, provider, _) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: productProvider.getListProduct.length,
                itemBuilder: ((context, index) {
                  final product = productProvider.getListProduct[index];

                  return GridItem(product: product);
                }),
              );
            },
          )
        ],
      ),
    );
  }
}

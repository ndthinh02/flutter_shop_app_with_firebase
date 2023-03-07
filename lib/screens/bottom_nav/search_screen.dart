import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/search_provider.dart';
import 'package:flutter_shop_app/widget/grird_item.dart';
import 'package:provider/provider.dart';

import '../../ui/text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchProvider get searchProvider => context.read<SearchProvider>();
  final TextEditingController _controller = TextEditingController();
  void seacrh(String query) {
    setState(() {
      searchProvider.searchProduct(query);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchProvider.getSearchProduct();
  }

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Search', style: MyTextStyle().textAppbar),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  child: TextFormField(
                    onChanged: (value) {
                      seacrh(value);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                        hintText: 'Search something',
                        prefixIcon: const Icon(Icons.search),
                        enabledBorder: outlineInputBorder,
                        border: outlineInputBorder,
                        focusedBorder: outlineInputBorder,
                        filled: true),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Popular Items",
                  style: MyTextStyle().textSubLogin,
                ),
                const SizedBox(
                  height: 40,
                ),
                Consumer<SearchProvider>(
                  builder: (context, value, child) {
                    if (value.getListSeacrhProduct.isEmpty) {
                      return const Center(
                        child: Text("No found product"),
                      );
                    }
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: searchProvider.getListSeacrhProduct.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              mainAxisExtent: 200,
                              childAspectRatio: 3 / 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        final product =
                            searchProvider.getListSeacrhProduct[index];
                        return GridItem(product: product);
                      },
                    );
                  },
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

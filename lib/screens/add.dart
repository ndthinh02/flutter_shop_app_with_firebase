import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/user_provider.dart';
import 'package:flutter_shop_app/ui/text_input.dart';
import 'package:provider/provider.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  UserProvider get userProvider => context.read<UserProvider>();
  UserProvider get watchUserProvider => context.watch<UserProvider>();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController priceOld = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController idProduct = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController rateStar = TextEditingController();
  clear() {
    name.text = "";
    price.text = "";
    image.text = "";
    description.text = "";
    priceOld.text = "";
    quantity.text = "";
    idProduct.text = "";
    type.text = "";
    rateStar.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextInput(
                textEditingController: name,
                hintText: 'name',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                textEditingController: price,
                hintText: 'price',
                isShowPass: false),
            TextInput(
                textEditingController: description,
                hintText: 'description',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                textEditingController: priceOld,
                hintText: 'priceOld',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                textEditingController: quantity,
                hintText: 'quantity',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                textEditingController: type,
                hintText: 'type',
                isShowPass: false),
            TextInput(
                textInputType: TextInputType.number,
                textEditingController: rateStar,
                hintText: 'rateStar',
                isShowPass: false),
            watchUserProvider.file == null
                ? GestureDetector(
                    onTap: () {
                      userProvider.updateAvatarUser(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://th.bing.com/th/id/OIP.CKFK1fo-TcgXoWtsFJnzTgHaHa?w=219&h=219&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      userProvider.updateAvatarUser(context);
                    },
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: Image.file(
                          File(watchUserProvider.file!.path).absolute,
                        ).image),
                  ),
            ElevatedButton(
                onPressed: () {
                  userProvider.addDatabase(
                      name.text,
                      price.text,
                      image.text,
                      description.text,
                      priceOld.text,
                      quantity.text,
                      type.text,
                      rateStar.text);
                },
                child: const Text('add')),
            ElevatedButton(
                onPressed: () {
                  clear();
                },
                child: const Text('clear'))
          ],
        ),
      ),
    );
  }
}

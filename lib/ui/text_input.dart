import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/text.dart';

import 'color.dart';

class TextInput extends StatelessWidget {
  final String faIcon;
  final TextEditingController textEditingController;
  final String hintText;

  bool isShowPass;
  IconButton? iconButton;
  TextInputType? textInputType;
  TextInput(
      {super.key,
      required this.faIcon,
      required this.textEditingController,
      required this.hintText,
      required this.isShowPass,
      this.textInputType,
      this.iconButton});

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(23));
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
            keyboardType: textInputType,
            obscureText: isShowPass,
            controller: textEditingController,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: MyTextStyle().textSeacrh,
                prefixIcon: Image(
                  image: AssetImage(faIcon),
                  width: 50,
                  height: 50,
                ),
                suffixIcon: iconButton,
                filled: true,
                border: outlineInputBorder,
                focusedBorder: outlineInputBorder,
                enabledBorder: outlineInputBorder),
          )
        ],
      ),
    );
  }
}

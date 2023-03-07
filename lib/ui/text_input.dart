import 'package:flutter/material.dart';
import 'package:flutter_shop_app/ui/text.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  IconData? icon;
  String? labelText;

  bool isShowPass;
  IconButton? iconButton;
  TextInputType? textInputType;
  TextInput(
      {super.key,
      this.icon,
      required this.textEditingController,
      required this.hintText,
      required this.isShowPass,
      this.textInputType,
      this.iconButton,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    var outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(23));
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            keyboardType: textInputType,
            obscureText: isShowPass,
            controller: textEditingController,
            decoration: InputDecoration(
                labelText: labelText,
                hintText: hintText,
                hintStyle: MyTextStyle().textSeacrh,
                prefixIcon: Icon(icon),
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

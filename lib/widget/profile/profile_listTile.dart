import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shop_app/ui/text.dart';

class ProfileListTile extends StatelessWidget {
  IconData iconleading;
  String name;
  IconData iconTraining;
  Color color;
  VoidCallback? onTap;
  ProfileListTile(
      {super.key,
      required this.iconleading,
      required this.color,
      required this.iconTraining,
      required this.name,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: Icon(
            iconleading,
            color: color,
          ),
          title: Text(
            name,
            style: MyTextStyle().textListTile,
          ),
          trailing: Icon(iconTraining),
        ),
      ),
    );
  }
}

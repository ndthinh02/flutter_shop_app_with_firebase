import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/user_provider.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:flutter_shop_app/ui/text_input.dart';
import 'package:provider/provider.dart';

import '../ui/text.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserProvider get userProvider => context.read<UserProvider>();
  UserProvider get watchUserProvider => context.watch<UserProvider>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  late final user = userProvider.getCurrentUser!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userProvider.getUserData();
    _name.text = user.name ?? "Username";
    _address.text = user.address ?? "Address";
    _phoneNumber.text = user.phoneNumber ?? "Phone number";
    _bio.text = user.bio ?? "Bio";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Your Profile',
            style: MyTextStyle().textAppbar,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    userProvider.updateAvatarUser(context);
                  },
                  child: watchUserProvider.file == null
                      ? CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: NetworkImage(user.urlImage ??
                              "https://th.bing.com/th/id/OIP.CKFK1fo-TcgXoWtsFJnzTgHaHa?w=219&h=219&c=7&r=0&o=5&dpr=1.1&pid=1.7"),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: Image.file(
                            File(watchUserProvider.file!.path).absolute,
                          ).image)),
              const SizedBox(height: 14),
              Text(user.email!),
              const SizedBox(height: 20),
              TextInput(
                  labelText: 'Username',
                  icon: Icons.person,
                  textEditingController: _name,
                  hintText: user.name ?? "Username",
                  isShowPass: false),
              const SizedBox(height: 4),
              TextInput(
                  labelText: "Address",
                  icon: Icons.location_on,
                  textEditingController: _address,
                  hintText: user.address ?? "My address",
                  isShowPass: false),
              const SizedBox(height: 4),
              TextInput(
                  labelText: "Bio",
                  icon: Icons.badge,
                  textEditingController: _bio,
                  hintText: user.bio ?? "Bio",
                  isShowPass: false),
              const SizedBox(height: 4),
              TextInput(
                  labelText: "PhoneNumber",
                  textInputType: TextInputType.number,
                  icon: Icons.phone,
                  textEditingController: _phoneNumber,
                  hintText: user.phoneNumber ?? "Phone number",
                  isShowPass: false),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    print('check quantity ${user.urlImage}');
                    userProvider.updateUser(user.email!, user.id!, _name.text,
                        _address.text, _bio.text, _phoneNumber.text, context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor: colorMain,
                  ),
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ));
  }
}

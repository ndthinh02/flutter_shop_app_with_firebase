import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/auth/auth_service.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/screens/checkout/history_order/history_order.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:flutter_shop_app/ui/text.dart';
import 'package:flutter_shop_app/widget/profile/profile_listTile.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider get userProvider => context.read<UserProvider>();
  UserProvider get watchUserProvider => context.read<UserProvider>();
  String? userName = "";
  String? bio = "";
  String? urlImage;
  getInfoUser() {
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
              if (mounted)
                {
                  setState(() {
                    userName = value["name"];
                    bio = value["bio"];
                    urlImage = value["urlImage"];
                  })
                }
            });
    // print('sjsnsjn $urlImage');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userProvider.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    getInfoUser();
    return Scaffold(
        appBar: AppBar(
          leading: null,
          centerTitle: true,
          title: Text(
            'Your Profile',
            style: MyTextStyle().textAppbar,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: watchUserProvider.currentUser == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50,
                          backgroundImage: NetworkImage(urlImage ??
                              "https://th.bing.com/th/id/R.8e2c571ff125b3531705198a15d3103c?rik=ybfg93p%2bdUyxOA&pid=ImgRaw&r=0")),
                      const SizedBox(height: 20),
                      Text(userName!),
                      Text(userProvider.currentUser!.email!),
                      const SizedBox(height: 10),
                      Text(bio!),
                      _buildListTile(context)
                    ],
                  )));
  }
}

Widget _buildListTile(BuildContext context) {
  final CreateRouter createRouter = Provider.of(context, listen: false);

  return Column(
    children: [
      ProfileListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const HistoryOrderScreen()));
        },
        iconleading: Icons.badge,
        iconTraining: Icons.arrow_forward_ios,
        name: 'My Order',
        color: Colors.red,
      ),
      ProfileListTile(
        onTap: () {
          Navigator.of(context).push(createRouter.createRouteEditProfilePage());
        },
        iconleading: Icons.edit,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Edit profile ',
        color: Colors.green,
      ),
      ProfileListTile(
        onTap: () {
          Navigator.of(context).push(createRouter.createRouteCartScreen());
        },
        iconleading: Icons.shopping_bag,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Your Cart',
        color: colorMain,
      ),
      ProfileListTile(
        onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => const Add()));
        },
        iconleading: Icons.star,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Your Review',
        color: const Color.fromARGB(255, 20, 9, 228),
      ),
      ProfileListTile(
        iconleading: Icons.help,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Help  ',
        color: Colors.black,
      ),
      ProfileListTile(
        iconleading: Icons.insights,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Statistics',
        color: Colors.red,
      ),
      ProfileListTile(
        onTap: () => AuthService().signOut(context),
        iconleading: Icons.meeting_room,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Sign out ',
        color: Colors.cyan,
      ),
    ],
  );
}

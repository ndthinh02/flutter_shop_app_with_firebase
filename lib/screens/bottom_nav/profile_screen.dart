import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_app/auth/auth_service.dart';
import 'package:flutter_shop_app/provider/create_router.dart';
import 'package:flutter_shop_app/screens/login/login.dart';
import 'package:flutter_shop_app/ui/color.dart';
import 'package:flutter_shop_app/ui/text.dart';
import 'package:flutter_shop_app/value/user.dart';
import 'package:flutter_shop_app/widget/profile/profile_listTile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          centerTitle: true,
          title: const Text(
            'Your Profile',
          ),
          backgroundColor: colorMain,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                clipper: CustomShape(),
                child: Container(
                  height: 200,
                  color: colorMain,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(UserApp.user.photoURL!),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        "User name",
                        style: MyTextStyle().titleText,
                      ),
                      Text(UserApp.user.email!),
                      const SizedBox(height: 20),
                      _buildListTile(context)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Widget _buildListTile(BuildContext context) {
  final CreateRouter createRouter = Provider.of(context, listen: false);

  return Column(
    children: [
      ProfileListTile(
        onTap: () => Navigator.of(context)
            .push(createRouter.createRouteEditProfilePage()),
        iconleading: Icons.visibility,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Recet view ',
        color: Colors.red,
      ),
      ProfileListTile(
        iconleading: Icons.edit,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Edit profile ',
        color: Colors.green,
      ),
      ProfileListTile(
        iconleading: Icons.shopping_bag,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Your Cart',
        color: colorMain,
      ),
      ProfileListTile(
        iconleading: Icons.star,
        iconTraining: Icons.arrow_forward_ios,
        name: 'Your Review',
        color: Color.fromARGB(255, 20, 9, 228),
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

class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double width = size.width;
    double height = size.height;
    path.lineTo(0, height - 100);
    path.quadraticBezierTo(width / 2, height, width, height / 2);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

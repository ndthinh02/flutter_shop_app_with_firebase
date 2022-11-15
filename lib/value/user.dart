import 'package:firebase_auth/firebase_auth.dart';

class UserApp {
  static final user = FirebaseAuth.instance.currentUser!;
  static String as = "";
}

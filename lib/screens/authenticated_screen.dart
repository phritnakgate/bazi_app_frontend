import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:bazi_app_frontend/screens/member_screen.dart';
import 'package:bazi_app_frontend/screens/registration_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedScreen extends StatefulWidget {
  const AuthenticatedScreen({super.key});

  @override
  State<AuthenticatedScreen> createState() => _AuthenticatedScreenState();
}

class _AuthenticatedScreenState extends State<AuthenticatedScreen> {
  bool? isNewUser;
  UserModel? userData;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    checkNewUser(user!.uid);
  }

  //Check if user is new or not
  Future<void> checkNewUser(String uid) async {
    bool isNew = await UserDataRepository().isFirstTimeUser(uid);
    setState(() {
      isNewUser = isNew;
    });
  }

  void onRegistrationComplete() {
    setState(() {
      isNewUser = false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    if (isNewUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return isNewUser!
          ? RegistrationScreen(onRegistrationComplete: onRegistrationComplete)
          : MemberScreen();
    }
  }
}

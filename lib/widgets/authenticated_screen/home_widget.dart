import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icomoon_free.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    User? userData = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                  flex: 1,
                  child: Iconify(
                    IcomoonFree.happy2,
                    size: 40,
                  )),
              Flexible(
                  flex: 4,
                  child: Text(
                    "สวัสดี! คุณ ${userData!.displayName}",
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  )),
              Flexible(
                  flex: 1,
                  child: IconButton(
                      iconSize: 30,
                      color: wColor,
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context).primaryColor)),
                      onPressed: () async {
                        await AuthenticationRepository().signOut();
                      },
                      icon: const Icon(Icons.logout))),
            ],
          ),
        ],
      ),
    );
  }
}

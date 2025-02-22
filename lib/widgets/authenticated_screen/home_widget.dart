import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icomoon_free.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({required this.userData, super.key});

  final UserModel userData;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                const Iconify(
                  IcomoonFree.happy2,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "สวัสดี! คุณ ${userData.name}",
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                IconButton(
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
                    icon: const Icon(Icons.logout)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

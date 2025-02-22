import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../repositories/hora_repository.dart';
import '../four_pillar_table_widget.dart';
import '../text_container_widget.dart';

class ProfileWidget extends StatelessWidget {
  ProfileWidget({required this.userData, super.key});

  final UserModel userData;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text("ข้อมูลส่วนตัว",
                  style: Theme.of(context).textTheme.headlineLarge),
            ),
            const SizedBox(height: 10),
            Container(
              height: 135,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(currentUser!.photoURL!),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      userData.email,
                      style: Theme.of(context).textTheme.bodySmall,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(userData.name,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(width: 5),
                        Icon(userData.gender == 0 ? Icons.male : Icons.female)
                      ],
                    ),
                    Text(userData.birthDate,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: fcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "แก้ไขข้อมูล",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: wColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
            const SizedBox(height: 20),
            Text("ธาตุประจำตัวและลักษณะนิสัยของคุณ",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            FourPillarTable(chart: userData.baziChart),
            const SizedBox(height: 20),
            Text(
              "ลักษณะนิสัย",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(userData
                        .baziChart
                        .dayPillar
                        .heavenlyStem
                        .name)[userData.baziChart.dayPillar.heavenlyStem.name]
                    ["pros"]),
            const SizedBox(height: 10),
            Text(
              "ข้อเสีย",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(userData
                        .baziChart
                        .dayPillar
                        .heavenlyStem
                        .name)[userData.baziChart.dayPillar.heavenlyStem.name]
                    ["cons"]),
            const SizedBox(height: 10),
            Text(
              "อาชีพที่เหมาะสม",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(userData
                    .baziChart.dayPillar.heavenlyStem.name)["occupation"]),
          ])),
    ));
  }
}

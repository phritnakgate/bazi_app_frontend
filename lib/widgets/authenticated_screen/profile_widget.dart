import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/user_model.dart';
import 'package:bazi_app_frontend/repositories/misc_repository.dart';
import 'package:bazi_app_frontend/repositories/userdata_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repositories/hora_repository.dart';
import '../widgets.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({required this.userData, super.key});

  final UserModel userData;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.userData.name;
    dateController.text = widget.userData.birthDate.split(" ")[0];
    timeController.text = widget.userData.birthDate.split(" ")[1];
  }

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
                      widget.userData.email,
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
                        Text(widget.userData.name,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(width: 5),
                        Icon(widget.userData.gender == 0
                            ? Icons.male
                            : Icons.female)
                      ],
                    ),
                    Text(
                        "${MiscRepository().displayThaiDate(widget.userData.birthDate.split(" ")[0])}, ${widget.userData.birthDate.split(" ")[1].substring(0, 5)} น.",
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
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                int selectedGender = widget.userData.gender;
                                return StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return AlertDialog(
                                      title: Center(
                                          child: Text(
                                        "ใส่ข้อมูลของท่าน",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            child: TextField(
                                              cursorColor:
                                                  Theme.of(context).focusColor,
                                              decoration: const InputDecoration(
                                                labelText: "ชื่อ",
                                              ),
                                              controller: nameController,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            spacing: 10,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime.now());
                                                  if (pickedDate != null &&
                                                      pickedDate !=
                                                          DateTime.now()) {
                                                    setState(() {
                                                      dateController
                                                          .text = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(pickedDate);
                                                      debugPrint(
                                                          dateController.text);
                                                    });
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: TextField(
                                                    controller: dateController,
                                                    enabled: false,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                "เลือกวันเกิด"),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  final TimeOfDay? timePicked =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now(),
                                                          builder:
                                                              (context, child) {
                                                            return MediaQuery(
                                                                data: MediaQuery.of(
                                                                        context)
                                                                    .copyWith(
                                                                        alwaysUse24HourFormat:
                                                                            true),
                                                                child: child!);
                                                          });
                                                  if (timePicked != null &&
                                                      timePicked !=
                                                          TimeOfDay.now()) {
                                                    setState(() {
                                                      timeController.text =
                                                          "${timePicked.hour.toString().padLeft(2, '0')}:${timePicked.minute.toString().padLeft(2, '0')}:00";
                                                    });
                                                  }
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: TextField(
                                                    controller: timeController,
                                                    enabled: false,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                "เลือกเวลาเกิด"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          GenderSelectorWidget(
                                            onGenderSelected: (gender) {
                                              setDialogState(() {
                                                selectedGender = gender;
                                              });
                                            },
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          GestureDetector(
                                              onTap: () {
                                                if (nameController.text.isEmpty ||
                                                    dateController
                                                        .text.isEmpty ||
                                                    timeController
                                                        .text.isEmpty) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "กรุณากรอกข้อมูลให้ครบถ้วน")));
                                                  return;
                                                }
                                                Navigator.pop(context, true);
                                                UserDataRepository()
                                                    .registerUser(
                                                        nameController.text,
                                                        dateController.text,
                                                        timeController.text,
                                                        selectedGender);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.75,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                    child: Text(
                                                  "แก้ไขข้อมูล",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(color: wColor),
                                                )),
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                        },
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
            const SizedBox(height: 20),
            Center(
              child: personalElementText(context,
                  widget.userData.baziChart.dayPillar.heavenlyStem.name),
            ),
            FourPillarTable(chart: widget.userData.baziChart),
            const SizedBox(height: 30),
            Text(
              "ลักษณะนิสัย",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(
                        widget.userData.baziChart.dayPillar.heavenlyStem.name)[
                    widget.userData.baziChart.dayPillar.heavenlyStem
                        .name]["pros"]),
            const SizedBox(height: 10),
            Text(
              "ข้อเสีย",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(
                        widget.userData.baziChart.dayPillar.heavenlyStem.name)[
                    widget.userData.baziChart.dayPillar.heavenlyStem
                        .name]["cons"]),
            const SizedBox(height: 10),
            Text(
              "อาชีพที่เหมาะสม",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            textContainer(
                Theme.of(context).textTheme.bodySmall!,
                MediaQuery.of(context).size.width * 0.95,
                100,
                HoraRepository().getBaseHora(widget.userData.baziChart.dayPillar
                    .heavenlyStem.name)["occupation"]),
          ])),
    ));
  }
}

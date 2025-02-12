import 'package:bazi_app_frontend/screens/guesthora_screen.dart';
import 'package:bazi_app_frontend/widgets/gender_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../configs/theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  int selectedGender = 0; //0 = Male, 1 = Female

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/welcome_pic.png',
                  scale: 1.1,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "ยินดีต้อนรับสู่ Bazi Harmony",
                  style: TextStyle(
                      color: wColor, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        int selectedGender = 0;
                        return StatefulBuilder(
                          builder: (context, setDialogState) {
                            return AlertDialog(
                              title: const Center(
                                  child: Text(
                                "ใส่ข้อมูลของท่าน",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: TextField(
                                      cursorColor: Theme.of(context).focusColor,
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
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now());
                                          if (pickedDate != null &&
                                              pickedDate != DateTime.now()) {
                                            setState(() {
                                              dateController.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(pickedDate);
                                              debugPrint(dateController.text);
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
                                            decoration: const InputDecoration(
                                                labelText: "เลือกวันเกิด"),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          final TimeOfDay? timePicked =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                  builder: (context, child) {
                                                    return MediaQuery(
                                                        data: MediaQuery.of(
                                                                context)
                                                            .copyWith(
                                                                alwaysUse24HourFormat:
                                                                    true),
                                                        child: child!);
                                                  });
                                          if (timePicked != null &&
                                              timePicked != TimeOfDay.now()) {
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
                                            decoration: const InputDecoration(
                                                labelText: "เลือกเวลาเกิด"),
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
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    GuestHoraScreen(
                                                      name: nameController.text,
                                                      birthDate:
                                                          dateController.text,
                                                      birthTime:
                                                          timeController.text,
                                                      gender: selectedGender,
                                                    )));
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const Center(
                                            child: Text(
                                          "วิเคราะห์พื้นดวง",
                                          style: TextStyle(color: wColor),
                                        )),
                                      ))
                                ],
                              ),
                            );
                          },
                        );
                      }),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: wColor),
                    child: const Center(
                        child: Text(
                      "ผู้เยี่ยมชม",
                      style: TextStyle(fontSize: 16),
                    )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

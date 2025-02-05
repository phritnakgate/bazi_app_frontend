import 'package:bazi_app_frontend/screens/guesthora_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const Color wColor = Color(0xFFF5E6E8);

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
                                width: MediaQuery.of(context).size.width * 0.65,
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
                                              "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: TextField(
                                        controller: dateController,
                                        enabled: false,
                                        decoration: const InputDecoration(
                                            labelText: "เลือกวันเกิด"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final TimeOfDay? timePicked =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now(),
                                              builder: (context, child) {
                                                return MediaQuery(
                                                    data: MediaQuery.of(context)
                                                        .copyWith(
                                                            alwaysUse24HourFormat:
                                                                true),
                                                    child: child!);
                                              });
                                      if (timePicked != null &&
                                          timePicked != TimeOfDay.now()) {
                                        setState(() {
                                          timeController.text =
                                              "${timePicked.hour}:${timePicked.minute}";
                                        });
                                      }
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                              Row(
                                children: [
                                  Text("เพศ"),
                                  Container(),
                                ],
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
                                                const GuestHoraScreen()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.75,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
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

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color wColor = Color(0xFFF5E6E8);
    const Widget spaceBox = SizedBox(
      height: 10,
    );

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
                spaceBox,
                GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                              child: Text(
                            "ใส่ข้อมูลของท่าน",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
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

import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
import 'package:bazi_app_frontend/repositories/hora_repository.dart';
import 'package:bazi_app_frontend/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GuestHoraScreen extends StatefulWidget {
  const GuestHoraScreen(
      {required this.name,
      required this.birthDate,
      required this.birthTime,
      required this.gender,
      super.key});
  final String name;
  final String birthDate;
  final String birthTime;
  final int gender;

  @override
  _GuestHoraScreenState createState() => _GuestHoraScreenState();
}

class _GuestHoraScreenState extends State<GuestHoraScreen> {
  late Future<BaziChart> futureBaziChart;

  @override
  void initState() {
    super.initState();
    // Initialize the Future when the widget is created
    futureBaziChart = getFourPillars();
  }

  Future<BaziChart> getFourPillars() async {
    return await FourPillarsRepository()
        .getFourPillars("${widget.birthDate} ${widget.birthTime}");
  }

  // HANDLE DATE DISPLAYING \\
  Map<String, String> thaiMonth = {
    "01": "มกราคม",
    "02": "กุมภาพันธ์",
    "03": "มีนาคม",
    "04": "เมษายน",
    "05": "พฤษภาคม",
    "06": "มิถุนายน",
    "07": "กรกฎาคม",
    "08": "สิงหาคม",
    "09": "กันยายน",
    "10": "ตุลาคม",
    "11": "พฤศจิกายน",
    "12": "ธันวาคม"
  };

  // HANDLE THAI ELEMENT DISPLAYING \\
  Map<String, String> thaiElement = {
    "Wood": "ไม้",
    "Fire": "ไฟ",
    "Earth": "ดิน",
    "Metal": "ทอง",
    "Water": "น้ำ"
  };
  Map<String, String> thaiYinyang = {
    "Yin": "หยิน(-)",
    "Yang": "หยาง(+)",
  };
  String displayThaiDate(String bdate) {
    List<String> date = bdate.split("-");
    String year = (int.parse(date[0]) + 543).toString();
    return "${date[2]} ${thaiMonth[date[1]]} $year";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: wColor,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Bazi Chart",
        ),
      ),
      body: FutureBuilder<BaziChart>(
        future: futureBaziChart, // Future to fetch BaziChart
        builder: (context, snapshot) {
          // Check the connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: fcolor));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data found');
          } else {
            // Display the Bazi chart data
            BaziChart baziChart = snapshot.data!;
            String element = baziChart.dayPillar.heavenlyStem.name;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "ผลการทำนาย",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          widget.gender == 0 ? Icons.male : Icons.female,
                          size: 40,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${widget.name}, ${displayThaiDate(widget.birthDate)} ${widget.birthTime.substring(0, 5)} น.",
                            style: Theme.of(context).textTheme.bodyLarge,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            const TextSpan(text: "คุณเป็นคนธาตุ "),
                            TextSpan(
                                text:
                                    "${thaiElement[element.split(" ")[1]]} ${thaiYinyang[element.split(" ")[0]]}",
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                      ),
                    ),
                    FourPillarTable(chart: baziChart),
                    const SizedBox(height: 30),
                    Text(
                      "ลักษณะนิสัย",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    textContainer(
                        Theme.of(context).textTheme.bodySmall!,
                        MediaQuery.of(context).size.width * 0.9,
                        100,
                        HoraRepository().getBaseHora(element)[element]["pros"]),
                    const SizedBox(height: 10),
                    Text(
                      "ข้อเสีย",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    textContainer(
                        Theme.of(context).textTheme.bodySmall!,
                        MediaQuery.of(context).size.width * 0.9,
                        100,
                        HoraRepository().getBaseHora(element)[element]["cons"]),
                    const SizedBox(height: 10),
                    Text(
                      "อาชีพที่เหมาะสม",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    textContainer(
                        Theme.of(context).textTheme.bodySmall!,
                        MediaQuery.of(context).size.width * 0.9,
                        100,
                        HoraRepository().getBaseHora(element)["occupation"]),
                    const SizedBox(height: 30),
                    // Center(
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width * 0.75,
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //       color: fcolor,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Center(
                    //       child: Text(
                    //         "กรุณาเข้าสู่ระบบเพื่อดูข้อมูลเพิ่มเติม",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodyMedium!
                    //             .copyWith(color: wColor),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

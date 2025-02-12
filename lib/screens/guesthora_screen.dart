import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
import 'package:bazi_app_frontend/widgets/four_pillar_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
            return const CircularProgressIndicator(); // Show loading spinner while fetching
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Handle error case
          } else if (!snapshot.hasData) {
            return const Text('No data found'); // Handle empty data case
          } else {
            // Display the Bazi chart data
            BaziChart baziChart = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                      Text(
                        "${widget.name}, ${displayThaiDate(widget.birthDate)} ${widget.birthTime.substring(0, 5)} น.",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FourPillarTable(chart: baziChart),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        const TextSpan(text: "คุณเป็นคนธาตุ "),
                        TextSpan(
                            text:
                                "${thaiElement[baziChart.dayPillar.heavenlyStem.name.split(" ")[1]]} ${thaiYinyang[baziChart.dayPillar.heavenlyStem.name.split(" ")[0]]}",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "พื้นดวงของ user",
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: BoxDecoration(
                      color: fcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "กรุณาเข้าสู่ระบบเพื่อดูข้อมูลเพิ่มเติม",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: wColor),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

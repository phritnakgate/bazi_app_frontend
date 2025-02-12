import 'package:bazi_app_frontend/configs/theme.dart';
import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:bazi_app_frontend/repositories/fourpillars_repository.dart';
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
      body: Center(
        child: FutureBuilder<BaziChart>(
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Name: ${widget.name}'),
                  Text('Birth Date: ${widget.birthDate}'),
                  Text('Birth Time: ${widget.birthTime}'),
                  Text(widget.gender == 0 ? "Male" : "Female"),
                  // Example display of data from Bazi chart
                  Text(
                      'Hour Pillar: ${baziChart.hourPillar.earthlyBranch.character}'),
                  Text('Day Pillar: ${baziChart.dayPillar.earthlyBranch.name}'),
                  Text(
                      'Month Pillar: ${baziChart.monthPillar.earthlyBranch.name}'),
                  Text(
                      'Year Pillar: ${baziChart.yearPillar.earthlyBranch.name}'),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

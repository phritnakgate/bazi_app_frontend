import 'dart:convert';

import '../models/basehora_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HoraRepository {
  final String? apiUrl = dotenv.env['API_URL'];
  final User user = FirebaseAuth.instance.currentUser!;

  // GET BASE HORA FROM MODEL \\
  Map<String, dynamic> getBaseHora(String element) {
    String baseElement = element.split(" ")[1].toLowerCase();
    return baseHoraData[baseElement];
  }

  // GET DAILY HORA DATA \\
  Future<Map<String, dynamic>> getDailyHora() async {
    final String? tk = await user.getIdToken();
    String uri = '$apiUrl/horo_scope/daily';
    final response = await http.get(
      Uri.parse(uri),
      headers: {
        "Authorization": "$tk",
        "Content-Type": "application/json",
      },
    );
    final calendarData = await getCalendarData(DateTime.now().month);
    String todayStatus = "";
    if (calendarData["goodDate"].contains(DateTime.now().day)) {
      todayStatus = "Good";
    } else if (calendarData["badDate"].contains(DateTime.now().day)) {
      todayStatus = "Bad";
    } else {
      todayStatus = "Neutral";
    }
    final Map<String, dynamic> todayHoro = {
      "status": todayStatus,
      "colors": jsonDecode(response.body)["colors"],
      "hours": jsonDecode(response.body)["hours"],
    };
    //print("Daily Hora API GOT Code: ${response.statusCode}, Body: ${response.body} And Today is $todayStatus");
    return todayHoro;
  }

  // GET CALENDAR DATA \\
  Future<Map<String, dynamic>> getCalendarData(int month) async {
    final String? tk = await user.getIdToken();
    String uri =
        '$apiUrl/horo_scope/calendar?month=$month&year=${DateTime.now().year}';

    final response = await http.get(
      Uri.parse(uri),
      headers: {
        "Authorization": "$tk",
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode != 200) {
      return {};
    } else {
      final respDate = jsonDecode(response.body);
      List<int> goodDate = [];
      List<int> badDate = [];
      respDate['good'].forEach((element) {
        goodDate.add(int.parse(element["date"].split("-")[2]));
      });
      respDate['bad'].forEach((element) {
        badDate.add(int.parse(element["date"].split("-")[2]));
      });
      return {
        "goodDate": goodDate,
        "badDate": badDate,
      };
    }
  }
}

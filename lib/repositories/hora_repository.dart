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
    final respDate = jsonDecode(response.body);
    
    //print("Calendar with $uri API GOT Code: ${response.statusCode}, Body: $respDate");
    return respDate;
  }
}

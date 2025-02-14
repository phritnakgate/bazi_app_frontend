import 'dart:convert';

import 'package:bazi_app_frontend/models/bazichart_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FourPillarsRepository {
  final String? apiUrl = dotenv.env['API_URL'];

  //HANDLE FOUR PILLARS CALCULATION
  Future<BaziChart> getFourPillars(String bdate) async {
    final payload = jsonEncode({
      "birth_date": bdate,
    });
    final response = await http.post(
      Uri.parse('$apiUrl/bazi_chart/'),
      headers: {"Content-Type": "application/json"},
      body: payload,
    );
    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}: ${response.body}');
    }else{
      final Map<String, dynamic> baziChartJson = jsonDecode(utf8.decode(response.bodyBytes));
      return BaziChart.fromJson(baziChartJson);
    }
    
  }
}

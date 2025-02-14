import 'package:bazi_app_frontend/models/fourpillars_model.dart';

class BaziChart {
  final HourPillar hourPillar;
  final DayPillar dayPillar;
  final MonthPillar monthPillar;
  final YearPillar yearPillar;

  BaziChart({
    required this.hourPillar,
    required this.dayPillar,
    required this.monthPillar,
    required this.yearPillar,
  });

  factory BaziChart.fromJson(Map<String, dynamic> json) {
    return BaziChart(
      hourPillar: HourPillar.fromJson(json['hour_pillar']),
      dayPillar: DayPillar.fromJson(json['day_pillar']),
      monthPillar: MonthPillar.fromJson(json['month_pillar']),
      yearPillar: YearPillar.fromJson(json['year_pillar']),
    );
  }
}

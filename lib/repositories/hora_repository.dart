import '../models/basehora_model.dart';

class HoraRepository {
  // GET BASE HORA FROM MODEL \\
  Map<String, dynamic> getBaseHora(String element) {
    String baseElement = element.split(" ")[1].toLowerCase();
    return baseHoraData[baseElement];
  }
}

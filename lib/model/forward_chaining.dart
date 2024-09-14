import 'package:mental_health_app/method/gejala.dart';
import 'package:mental_health_app/method/rule.dart';

class ForwardChaining {
  List<Gejala> gejalaInput;
  List<Rule> rules;

  ForwardChaining({required this.gejalaInput, required this.rules});

  String applyForwardChaining() {
    for (var rule in rules) {
      bool match = rule.gejalaIds.every((id) {
        // Cari gejala yang sesuai dengan id dan punya severity yang bukan "Tidak pernah"
        return gejalaInput.any((gejala) => gejala.id == id && _isRelevantSeverity(gejala.severity));
      });

      if (match) {
        // Jika semua gejala dalam satu aturan cocok, return hasil diagnosa
        return rule.hasil;
      }
    }
    return "Tidak ditemukan diagnosa";
  }

  // Metode untuk memeriksa apakah severity relevan
  bool _isRelevantSeverity(String severity) {
    // Pencocokan gejala dengan tingkat keparahan yang relevan (bukan "Tidak pernah")
    return severity == 'sangat sering' || 
           severity == 'sering' || 
           severity == 'kadang-kadang' || 
           severity == 'jarang';
  }
}

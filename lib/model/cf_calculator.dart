import 'package:mental_health_app/method/gejala.dart';

double hitungCertaintyFactor(List<Gejala> gejalaList) {
  double? cfTotal;

  for (var gejala in gejalaList) {
    double cfUser = gejala.getCfUser(); // Dapatkan nilai cfUser dari jawaban pengguna
    if (cfUser != 0.0) {
      double cfHE = gejala.cfPakar * cfUser; // Hitung CF[H,E] = CF pakar * CF user
      if (cfTotal == null) {
        cfTotal = cfHE;
      } else {
        // Kombinasi CF jika lebih dari satu gejala
        cfTotal = cfTotal + (cfHE * (1 - cfTotal));
      }
    }
  }

  return cfTotal ?? 0.0; // Kembalikan CF total
}

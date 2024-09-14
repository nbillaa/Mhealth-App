class Gejala {
  final String id;
  final String pertanyaan;
  final double cfPakar;
  String severity; // Tambahkan properti untuk jawaban pengguna

  Gejala({
    required this.id,
    required this.pertanyaan,
    required this.cfPakar,
    this.severity = 'tidak pernah', // Default jawaban
  });
  
  // Fungsi untuk set nilai keparahan berdasarkan input pengguna
  void setSeverity(String userSeverity) {
    severity = userSeverity;
  }
  
  // Fungsi untuk mendapatkan nilai CF berdasarkan jawaban pengguna
  double getCfUser() {
    switch (severity) {
      case 'sangat sering':
        return 1.0; // Nilai CF user untuk sangat sering
      case 'sering':
        return 0.8;
      case 'kadang-kadang':
        return 0.6;
      case 'jarang':
        return 0.4;
      case 'tidak pernah':
      default:
        return 0.0;
    }
  }
}

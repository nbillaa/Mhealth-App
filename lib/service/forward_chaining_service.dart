import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mental_health_app/model/forward_chaining.dart';

class ForwardChainingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Ambil jawaban dari Firestore dan konversi menjadi numerik
  Future<Map<String, double>> getAnswersAndConvertToNumeric(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('answers').doc(userId).get();
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        // Konversi jawaban ke nilai numerik
        return data.map((key, value) => MapEntry(key, _convertAnswerToNumeric(value)));
      } else {
        throw Exception("No data found for user $userId");
      }
    } catch (e) {
      print("Failed to get answers: $e");
      return {};
    }
  }

  // Konversi jawaban dari teks ke angka sesuai skala 0.8, 0.6, 0.4, 0.2, 0
  double _convertAnswerToNumeric(String answer) {
    switch (answer) {
      case 'Sangat sering':
        return 0.8;
      case 'Sering':
        return 0.6;
      case 'Kadang-kadang':
        return 0.4;
      case 'Jarang':
        return 0.2;
      case 'Tidak pernah':
        return 0.0;
      default:
        return -1.0; // Nilai default jika tidak valid
    }
  }

  // Proses forward chaining dengan menggunakan jawaban yang diambil
  Future<String> processForwardChaining(String userId) async {
    // Ambil jawaban yang telah dikonversi
    Map<String, double> answers = await getAnswersAndConvertToNumeric(userId);

    // Terapkan forward chaining
    ForwardChaining forwardChaining = ForwardChaining(gejalaInput: [], rules: []);
    String diagnosis = forwardChaining.applyForwardChaining();

    return diagnosis;
  }
}

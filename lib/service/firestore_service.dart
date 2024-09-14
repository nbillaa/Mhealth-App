/* import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Metode untuk mengambil jawaban dari Firestore dan mengonversi ke numerik
  Future<Map<String, int>> getAnswersAndConvertToNumeric(String userId) async {
    try {
      // Ambil data jawaban dari Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('answers').doc(userId).get();
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        // Konversi jawaban dari teks ke angka
        return data.map((key, value) => MapEntry(key, _convertAnswerToNumeric(value)));
      } else {
        throw Exception("No data found for user $userId");
      }
    } catch (e) {
      print("Failed to get answers: $e");
      return {};
    }
  }

  // Metode untuk mengonversi jawaban dari teks ke angka
  int _convertAnswerToNumeric(String answer) {
    switch (answer) {
      case 'Sangat sering':
        return 4;
      case 'Sering':
        return 3;
      case 'Kadang-kadang':
        return 2;
      case 'Jarang':
        return 1;
      case 'Tidak pernah':
        return 0;
      default:
        return -1; // Nilai default jika tidak valid
    }
  }

  // Metode untuk menyimpan hasil diagnosis ke Firestore
  Future<void> saveDiagnosisResult(String userId, Map<String, dynamic> diagnosisData) async {
    try {
      // Simpan hasil diagnosis di koleksi "diagnosis_results" berdasarkan userId
      await _firestore.collection('diagnosis_results').doc(userId).set(diagnosisData, SetOptions(merge: true));
      print("Diagnosis result saved successfully.");
    } catch (e) {
      print("Failed to save diagnosis result: $e");
      throw e;
    }
  }

  saveAnswers(String userId, Map<String, dynamic> answers) {}

  getDiagnosisResult(String userId) {}

  getGejalaData(String userId) {}
}
 */

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Metode untuk mengambil jawaban dari Firestore dan mengonversi ke numerik
  Future<Map<String, int>> getAnswersAndConvertToNumeric(String userId) async {
    try {
      // Ambil data jawaban dari Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('answers').doc(userId).get();
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        // Konversi jawaban dari teks ke angka
        return data.map((key, value) => MapEntry(key, _convertAnswerToNumeric(value)));
      } else {
        throw Exception("No data found for user $userId");
      }
    } catch (e) {
      print("Failed to get answers: $e");
      return {};
    }
  }

  // Metode untuk mengonversi jawaban dari teks ke angka
  int _convertAnswerToNumeric(String answer) {
    switch (answer) {
      case 'Sangat sering':
        return 4;
      case 'Sering':
        return 3;
      case 'Kadang-kadang':
        return 2;
      case 'Jarang':
        return 1;
      case 'Tidak pernah':
        return 0;
      default:
        return -1; // Nilai default jika tidak valid
    }
  }

  // Metode untuk menyimpan hasil diagnosis ke Firestore
  Future<void> saveDiagnosisResult(String userId, Map<String, dynamic> diagnosisData) async {
    try {
      // Simpan hasil diagnosis di koleksi "diagnosis_results" berdasarkan userId
      await _firestore.collection('diagnosis_results').doc(userId).set(diagnosisData, SetOptions(merge: true));
      print("Diagnosis result saved successfully.");
    } catch (e) {
      print("Failed to save diagnosis result: $e");
      throw e;
    }
  }

  // Metode untuk mengambil hasil prediksi ONNX dari Firestore
  Future<Map<String, dynamic>> getOnnxPrediction(String userId) async {
    try {
      // Ambil data prediksi dari koleksi "onnx_predictions" berdasarkan userId
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('onnx_predictions').doc(userId).get();
      Map<String, dynamic>? data = snapshot.data();

      if (data != null) {
        return data; // Kembalikan data prediksi
      } else {
        throw Exception("No ONNX prediction found for user $userId");
      }
    } catch (e) {
      print("Failed to get ONNX prediction: $e");
      return {};
    }
  }

  // Metode lain yang mungkin belum diimplementasikan
  Future<void> saveAnswers(String userId, Map<String, dynamic> answers) async {
    // Implementasi penyimpanan jawaban pengguna
  }

  Future<Map<String, dynamic>> getDiagnosisResult(String userId) async {
    // Implementasi untuk mengambil hasil diagnosis dari Firestore
    return {};
  }

  Future<Map<String, dynamic>> getGejalaData(String userId) async {
    // Implementasi untuk mengambil data gejala dari Firestore
    return {};
  }
}
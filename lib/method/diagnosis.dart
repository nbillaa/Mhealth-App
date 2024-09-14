/* import 'package:mental_health_app/method/gejala.dart';
import 'package:mental_health_app/method/rule.dart';
import 'package:mental_health_app/method/data_gejala.dart';
import 'package:mental_health_app/model/cf_calculator.dart';
import 'package:mental_health_app/model/onnx_model.dart';
import 'package:mental_health_app/service/firestore_service.dart';
import 'package:mental_health_app/service/forward_chaining_service.dart'; // Mengimpor gejala dan rules

class DiagnosisProcessor {
  final OnnxModel onnxModel = OnnxModel();
  final ForwardChainingService forwardChainingService = ForwardChainingService();
  final FirestoreService firestoreService = FirestoreService();

  Future<void> processDiagnosis(String userId) async {
    // Step 1: Ambil data jawaban dari Firestore dan konversi menjadi numerik
    Map<String, int> numericAnswers = await firestoreService.getAnswersAndConvertToNumeric(userId);
    
    if (numericAnswers.isNotEmpty) {
      // Step 2: Jalankan prediksi menggunakan model ONNX
      List predictionResult = await onnxModel.runModelWithAnswers(numericAnswers);
      print("Prediction result (ONNX): $predictionResult");

      // Step 3: Jalankan forward chaining berdasarkan gejala yang ada
      String forwardChainingResult = await forwardChainingService.processForwardChaining(userId);
      print("Forward Chaining result: $forwardChainingResult");

      // Step 4: Ambil gejala untuk setiap penyakit
      List<Gejala> gejalaDepresi = ambilGejalaUntukPenyakit('Depresi');
      List<Gejala> gejalaAnxiety = ambilGejalaUntukPenyakit('Anxiety');
      List<Gejala> gejalaBipolar = ambilGejalaUntukPenyakit('Bipolar');

      // Step 5: Hitung CF untuk masing-masing penyakit
      double cfDepresi = hitungCertaintyFactor(gejalaDepresi);
      double cfAnxiety = hitungCertaintyFactor(gejalaAnxiety);
      double cfBipolar = hitungCertaintyFactor(gejalaBipolar);

      // Step 6: Bandingkan hasil CF
      String diagnosis = '';
      double finalCF = 0.0;
      if (cfDepresi > cfAnxiety && cfDepresi > cfBipolar) {
        diagnosis = "Depresi";
        finalCF = cfDepresi;
      } else if (cfAnxiety > cfDepresi && cfAnxiety > cfBipolar) {
        diagnosis = "Anxiety";
        finalCF = cfAnxiety;
      } else {
        diagnosis = "Bipolar";
        finalCF = cfBipolar;
      }
      print("Diagnosis: $diagnosis dengan CF $finalCF");

      // Step 7: Simpan hasil akhir diagnosis ke Firebase
      await firestoreService.saveDiagnosisResult(userId, {
        'predictionResult': predictionResult,
        'forwardChainingResult': forwardChainingResult,
        'finalDiagnosis': diagnosis,
        'certaintyFactor': finalCF,
        'diagnosisDate': DateTime.now(),
      });

      print("Diagnosis process completed and saved to Firebase.");
    }
  }

  // Fungsi untuk mengumpulkan gejala berdasarkan aturan (rules)
  List<Gejala> ambilGejalaUntukPenyakit(String penyakit) {
    // Cari aturan yang sesuai dengan penyakit
    Rule rule = rulesList.firstWhere((rule) => rule.hasil == penyakit);
    
    // Ambil gejala yang sesuai dengan ID dari aturan
    return gejalaList.where((gejala) => rule.gejalaIds.contains(gejala.id)).toList();
  }

  // Fungsi opsional untuk menyimpan hasil di Firebase (sudah ditangani di FirestoreService)
  void simpanHasilDiFirebase(double cfDepresi, double cfAnxiety, double cfBipolar) {
    // Logika penyimpanan hasil di Firebase (sudah ditangani di FirestoreService)
  }
} */

import 'package:mental_health_app/model/onnx_model.dart';
import 'package:mental_health_app/service/firestore_service.dart';

class DiagnosisProcessor {
  final OnnxModel onnxModel = OnnxModel();
  final FirestoreService firestoreService = FirestoreService();

  Future<void> processDiagnosis(String userId) async {
  // Step 1: Ambil data jawaban dari Firestore dan konversi menjadi numerik
  Map<String, int> numericAnswers = await firestoreService.getAnswersAndConvertToNumeric(userId);

  if (numericAnswers.isNotEmpty) {
    // Step 2: Jalankan prediksi menggunakan model ONNX
    List? predictionResult = await onnxModel.runModelWithAnswers(numericAnswers);
    
    if (predictionResult != null) {
      print("Prediction result (ONNX): $predictionResult");

      // Step 3: Simpan hasil akhir prediksi ONNX ke Firebase
      await firestoreService.saveDiagnosisResult(userId, {
        'predictionResult': predictionResult,
        'diagnosisDate': DateTime.now(),
      });

      print("Diagnosis process completed and saved to Firebase.");
    } else {
      print("Prediction result is null for user $userId");
    }
  } else {
    print("No answers found for user $userId");
  }
}

}

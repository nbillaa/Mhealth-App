import 'package:mental_health_app/model/onnx_model.dart';
import 'package:mental_health_app/method/answer.dart';  // Pastikan untuk mengimpor class Answer

class DiagnosisProcessor {
  final OnnxModel onnxModel = OnnxModel();
  final Answer userAnswers; // Menyimpan instance Answer

  DiagnosisProcessor(this.userAnswers);

  Future<void> processDiagnosis() async {
    // Step 1: Konversi data jawaban dari objek Answer menjadi numerik
    Map<String, int> numericAnswers = userAnswers.toNumeric();
    
    if (numericAnswers.isNotEmpty) {
      // Step 2: Jalankan prediksi menggunakan model ONNX
      List<double> inputForModel = numericAnswers.values.toList().map((e) => e.toDouble()).toList();
      List predictionResult = await onnxModel.runModel(inputForModel);
      print("Prediction result (ONNX): $predictionResult");

      // Step 3: Simpan hasil akhir prediksi ONNX ke Firebase
      await _saveDiagnosisResult({
        'predictionResult': predictionResult,
        'diagnosisDate': DateTime.now(),
      });

      print("Diagnosis process completed and saved to Firebase.");
    } else {
      print("No answers available for diagnosis.");
    }
  }

  Future<void> _saveDiagnosisResult(Map<String, dynamic> result) async {
    // Simpan hasil ke Firebase Firestore (ini adalah contoh fungsi, implementasikan sesuai kebutuhan)
    // Implementasikan penyimpanan hasil ke Firebase Firestore di sini
  }
}

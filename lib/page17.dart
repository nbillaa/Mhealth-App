import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_app/method/answer.dart';
import 'package:mental_health_app/model/onnx_model.dart';

class PertanyaanPage17 extends StatefulWidget {
  static String routeName = 'PertanyaanPage17';
  const PertanyaanPage17({super.key});

  @override
  _PertanyaanPage17State createState() => _PertanyaanPage17State();
}

Answer userAnswers = Answer(answers: {});
OnnxModel onnxModel = OnnxModel();  // Inisialisasi model ONNX

class _PertanyaanPage17State extends State<PertanyaanPage17> {
  String? _selectedOption1;
  String? _selectedOption2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E0F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0E0F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pertanyaan',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF004AAD),
          ),
        ),
        actions: [
          IntrinsicWidth(
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E91EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '17 of 17',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildQuestionCard(
              'Apakah kamu pernah melakukan hal-hal yang aneh atau tidak biasa?',
              _selectedOption1,
              (value) {
                setState(() {
                  _selectedOption1 = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildQuestionCard(
              'Apakah kamu memiliki keinginan untuk bunuh diri?',
              _selectedOption2,
              (value) {
                setState(() {
                  _selectedOption2 = value;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_selectedOption1 != null && _selectedOption2 != null) {
                  _saveAnswers(); // Simpan jawaban ke dalam userAnswers

                  // Gunakan metode toNumeric dari Answer untuk konversi jawaban
                  Map<String, int> numericAnswers = userAnswers.toNumeric();
                  List<double> inputData = numericAnswers.values.map((e) => e.toDouble()).toList();

                  // Jalankan model ONNX dengan input numerik
                  List<double> onnxResult = await onnxModel.runModel(inputData);

                  // Simpan hasil prediksi ke Firebase
                  await _savePredictionToFirebase(onnxResult);

                  // Lanjutkan dengan hasil prediksi, bisa simpan ke Firebase atau tampilkan hasilnya
                  print("Hasil prediksi ONNX: $onnxResult");

                  // Arahkan ke halaman hasil
                  Navigator.pushNamed(context, 'ResultPage');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Semua pertanyaan harus dijawab!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004AAD),
                padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(String question, String? selectedOption, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF004AAD),
            ),
          ),
          const SizedBox(height: 10),
          _buildOption('Sangat sering', selectedOption, onChanged),
          _buildOption('Sering', selectedOption, onChanged),
          _buildOption('Kadang-kadang', selectedOption, onChanged),
          _buildOption('Jarang', selectedOption, onChanged),
          _buildOption('Tidak pernah', selectedOption, onChanged),
        ],
      ),
    );
  }

  Widget _buildOption(String text, String? groupValue, Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF004AAD)),
      ),
      value: text,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF004AAD),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }

  void _saveAnswers() {
    // Simpan jawaban dari halaman ini
    userAnswers.updateAnswer('GE34', _selectedOption1 ?? '');
    userAnswers.updateAnswer('GE36', _selectedOption2 ?? '');
  }

  Future<void> _savePredictionToFirebase(List<double> predictionResults) async {
    try {
      // Akses ke Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Simpan hasil ke Firestore dengan koleksi "predictions"
      await firestore.collection('predictions').add({
        'timestamp': Timestamp.now(),
        'user_answers': userAnswers.answers,
        'prediction_results': predictionResults,
      });

      print('Prediksi berhasil disimpan ke Firebase');
    } catch (e) {
      print('Gagal menyimpan prediksi ke Firebase: $e');
    }
  }
}

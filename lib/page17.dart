/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_app/method/gejala.dart';
import 'package:mental_health_app/model/cf_calculator.dart';
import 'package:mental_health_app/service/firestore_service.dart';
import 'package:mental_health_app/service/forward_chaining_service.dart'; // Import ForwardChainingService
import 'package:mental_health_app/model/onnx_model.dart';

class PertanyaanPage17 extends StatefulWidget {
  static String routeName = 'PertanyaanPage17';
  const PertanyaanPage17({super.key});

  @override
  _PertanyaanPage17State createState() => _PertanyaanPage17State();
}

class _PertanyaanPage17State extends State<PertanyaanPage17> {
  String? _selectedOption1;
  String? _selectedOption2;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            // Handle back button press
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
        centerTitle: false,
        actions: [
          IntrinsicWidth(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                alignment: Alignment.center,
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
              'Apakah kamu pernah melakukan hal-hal yang aneh atau tidak biasa, yang menurut orang lain berlebihan, bodoh, atau berbahaya (misalnya menghamburkan uang)?',
              _selectedOption1,
              (value) {
                setState(() {
                  _selectedOption1 = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildQuestionCard(
              'Apakah kamu memiliki keinginan untuk bunuh diri atau percobaan bunuh diri?',
              _selectedOption2,
              (value) {
                setState(() {
                  _selectedOption2 = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _saveAnswers(); // Simpan jawaban sebelum melanjutkan
                  
                  // Jalankan model ONNX dan forward chaining setelah jawaban disimpan
                  await runDetectionProcess();
                  
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, 'ResultPage');
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
      dense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFF004AAD),
        ),
      ),
      value: text,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF004AAD),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }

  Future<void> _saveAnswers() async {
    final userId = _auth.currentUser?.uid ?? 'guest'; // Gunakan ID pengguna yang login
    final Map<String, String> answers = {
      'GE34': _selectedOption1 ?? '',
      'GE36': _selectedOption2 ?? '',
      // Tambahkan jawaban dari halaman lain jika diperlukan
    };

    try {
      await _firestore.collection('answers').doc(userId).set(answers, SetOptions(merge: true));
    } catch (e) {
      print("Failed to save answers: $e");
    }
  }

  Future<void> runDetectionProcess() async {
    FirestoreService firestoreService = FirestoreService();
    OnnxModel onnxModel = OnnxModel();
    ForwardChainingService forwardChainingService = ForwardChainingService(); // Forward chaining service

    final userId = _auth.currentUser?.uid ?? 'guest'; // Gunakan ID pengguna yang login

    // Ambil jawaban dari Firestore dan konversikan ke numerik
    Map<String, int> numericAnswers = await firestoreService.getAnswersAndConvertToNumeric(userId);

    if (numericAnswers.isNotEmpty) {
      // Lakukan prediksi menggunakan model ONNX
      List predictionResult = await onnxModel.runModelWithAnswers(numericAnswers);
      
      // Output hasil prediksi (untuk contoh)
      print("Prediction result (ONNX): $predictionResult");

      // Jalankan forward chaining
      String forwardChainingResult = await forwardChainingService.processForwardChaining(userId);

      // Output hasil forward chaining
      print("Forward Chaining result: $forwardChainingResult");

      // Hitung Certainty Factor
      double certaintyFactorResult = await calculateCertaintyFactor(userId);

      // Output hasil Certainty Factor
      print("Certainty Factor result: $certaintyFactorResult");

      // Anda bisa menyimpan atau menggunakan hasil prediksi sesuai dengan kebutuhan
    }
  }

  Future<double> calculateCertaintyFactor(String userId) async {
    FirestoreService firestoreService = FirestoreService();

    // Ambil data gejala dari Firestore
    List<Gejala> gejalaList = await firestoreService.getGejalaData(userId);

    // Hitung CF total menggunakan fungsi dari cf_calculator.dart
    double cfTotal = hitungCertaintyFactor(gejalaList);

    return cfTotal;
  }
} */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';// Import halaman diagnosa
import 'package:mental_health_app/method/diagnosis.dart';
class PertanyaanPage17 extends StatefulWidget {
  static String routeName = 'PertanyaanPage17';
  const PertanyaanPage17({super.key});

  @override
  _PertanyaanPage17State createState() => _PertanyaanPage17State();
}

class _PertanyaanPage17State extends State<PertanyaanPage17> {
  String? _selectedOption1;
  String? _selectedOption2;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
        centerTitle: false,
        actions: [
          IntrinsicWidth(
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Container(
                alignment: Alignment.center,
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
              'Apakah kamu pernah melakukan hal-hal yang aneh atau tidak biasa, yang menurut orang lain berlebihan, bodoh, atau berbahaya (misalnya menghamburkan uang)?',
              _selectedOption1,
              (value) {
                setState(() {
                  _selectedOption1 = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildQuestionCard(
              'Apakah kamu memiliki keinginan untuk bunuh diri atau percobaan bunuh diri?',
              _selectedOption2,
              (value) {
                setState(() {
                  _selectedOption2 = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  // Validasi apakah semua jawaban sudah diisi
                  if (_selectedOption1 != null && _selectedOption2 != null) {
                    await _saveAnswers(); // Simpan jawaban

                    // Jalankan proses diagnosa setelah jawaban disimpan
                    await _runDiagnosis();

                    // Arahkan ke halaman hasil setelah proses selesai
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(context, 'ResultPage');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Semua pertanyaan harus dijawab!"))
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
      dense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      title: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: const Color(0xFF004AAD),
        ),
      ),
      value: text,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: const Color(0xFF004AAD),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
    );
  }

  Future<void> _saveAnswers() async {
    final userId = _auth.currentUser?.uid ?? 'guest'; // Gunakan ID pengguna yang login
    final Map<String, String> answers = {
      'GE34': _selectedOption1 ?? '',
      'GE36': _selectedOption2 ?? '',
    };

    try {
      await _firestore.collection('answers').doc(userId).set(answers, SetOptions(merge: true));
    } catch (e) {
      print("Failed to save answers: $e");
    }
  }

  Future<void> _runDiagnosis() async {
    // Panggil DiagnosisProcessor dari diagnosa.dart
    final userId = _auth.currentUser?.uid ?? 'guest';
    final diagnosisProcessor = DiagnosisProcessor();

    await diagnosisProcessor.processDiagnosis(userId);
  }
}

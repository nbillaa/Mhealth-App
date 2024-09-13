import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_app/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPage extends StatefulWidget {
  static String routeName = 'ResultPage';

  const ResultPage({super.key});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _diagnosis = '';
  double _certaintyFactor = 0.0;
  bool _isLoading = true;

  // Fungsi untuk mengambil hasil diagnosis dari Firestore
  Future<void> _getDiagnosisResult() async {
    try {
      final userId = _auth.currentUser?.uid ?? 'guest';
      final diagnosisData = await _firestoreService.getDiagnosisResult(userId);
      setState(() {
        _diagnosis = diagnosisData['finalDiagnosis'] ?? 'Tidak ada diagnosis';
        _certaintyFactor = diagnosisData['certaintyFactor'] ?? 0.0;
        _isLoading = false;
      });
    } catch (e) {
      print('Gagal mengambil hasil diagnosis: $e');
      setState(() {
        _diagnosis = 'Error';
        _certaintyFactor = 0.0;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getDiagnosisResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hasil Diagnosis',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF004AAD),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Hasil Diagnosis Anda',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Penyakit yang terdeteksi:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    _diagnosis,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Tingkat Kepastian Diagnosis:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${(_certaintyFactor * 100).toStringAsFixed(2)}%',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Kembali ke halaman sebelumnya
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004AAD),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      'Kembali',
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
}

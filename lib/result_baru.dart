import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatefulWidget {
  static String routeName = 'ResultPage';

  final String userId; // ID pengguna untuk mengambil hasil dari Firebase

  const ResultPage({
    super.key,
    required this.userId, required String onnxPrediction, required String xgboostPrediction,
  });

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isLoading = true;
  String? _onnxPrediction;
  String? _xgboostPrediction;

  @override
  void initState() {
    super.initState();
    _getResultsFromFirebase();
  }

  // Fungsi untuk mengambil hasil prediksi dari Firestore
  Future<void> _getResultsFromFirebase() async {
    try {
      // Referensi ke dokumen hasil di Firestore menggunakan userId
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('diagnosis_results')
          .doc(widget.userId)
          .get();

      if (snapshot.exists) {
        // Mendapatkan hasil prediksi dari data yang disimpan di Firestore
        setState(() {
          _onnxPrediction = snapshot.data()?['onnxPrediction'] ?? 'Tidak ada hasil ONNX';
          _xgboostPrediction = snapshot.data()?['xgboostPrediction'] ?? 'Tidak ada hasil XGBoost';
          _isLoading = false;
        });
      } else {
        setState(() {
          _onnxPrediction = 'Hasil tidak ditemukan';
          _xgboostPrediction = 'Hasil tidak ditemukan';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _onnxPrediction = 'Error mengambil data';
        _xgboostPrediction = 'Error mengambil data';
        _isLoading = false;
      });
      print("Error getting diagnosis results: $e");
    }
  }

  // Fungsi untuk memberikan interpretasi hasil prediksi model
  String _interpretPrediction(String prediction) {
    switch (prediction.toLowerCase()) {
      case "depression":
        return "Depresi - Kami mendeteksi adanya tanda-tanda depresi. Penting untuk mencari dukungan profesional.";
      case "anxiety":
        return "Kecemasan - Terdapat gejala kecemasan. Pertimbangkan untuk berbicara dengan seorang ahli.";
      case "bipolar":
        return "Gangguan Bipolar - Kami mendeteksi gejala gangguan bipolar. Konsultasi dengan dokter dianjurkan.";
      default:
        return "Hasil tidak terdeteksi atau tidak cukup data untuk diagnosis yang jelas.";
    }
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
          ? const Center(child: CircularProgressIndicator())
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
                  const SizedBox(height: 20),

                  // Hasil Prediksi ONNX
                  Text(
                    'Hasil Prediksi ONNX:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.blue.shade50,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            _onnxPrediction ?? 'Loading...',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _onnxPrediction != null
                                ? _interpretPrediction(_onnxPrediction!)
                                : 'Loading...',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Hasil Prediksi XGBoost
                  Text(
                    'Hasil Prediksi XGBoost:',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.green.shade50,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            _xgboostPrediction ?? 'Loading...',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.greenAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _xgboostPrediction != null
                                ? _interpretPrediction(_xgboostPrediction!)
                                : 'Loading...',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

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

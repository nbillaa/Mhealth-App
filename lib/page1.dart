import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PertanyaanPage extends StatefulWidget {
  static String routeName = 'PertanyaanPage';
  const PertanyaanPage({super.key});

  @override
  _PertanyaanPageState createState() => _PertanyaanPageState();
}

class _PertanyaanPageState extends State<PertanyaanPage> {
  String? _selectedOption1;
  String? _selectedOption2;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBDBF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDBDBF4),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E91EA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '1 of 17',
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            _buildQuestionCard(
              'Apakah kamu sering merasakan perasaan sedih (sedih, putus asa, tak berdaya, dan tak berguna)?',
              _selectedOption1,
              (value) {
                setState(() {
                  _selectedOption1 = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildQuestionCard(
              'Apakah kamu sering merasa bersalah seperti menyalahkan diri sendiri dan pemikiran bersalah atau renungan tentang perbuatan salah?',
              _selectedOption2,
              (value) {
                setState(() {
                  _selectedOption2 = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: ElevatedButton(
                onPressed: () async {
                  await _saveAnswers();
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, 'PertanyaanPage2');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'Continue',
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

  Widget _buildQuestionCard(
      String question, String? selectedOption, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          _buildOption('Sangat sering', selectedOption, onChanged),
          _buildOption('Sering', selectedOption, onChanged),
          _buildOption('Kadang-kadang', selectedOption, onChanged),
          _buildOption('Jarang', selectedOption, onChanged),
          _buildOption('Tidak pernah', selectedOption, onChanged),
        ],
      ),
    );
  }

  Widget _buildOption(
      String text, String? groupValue, Function(String?) onChanged) {
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

    // Menggunakan kode gejala yang diimpor dari data_gejala.dart
    final Map<String, String> answers = {
      'GE01': _selectedOption1 ?? '', // Menggunakan kode gejala dari data_gejala.dart
      'GE04': _selectedOption2 ?? '',
      // Tambahkan jawaban dari halaman lain jika diperlukan
    };

    try {
      await _firestore.collection('answers').doc(userId).set(answers, SetOptions(merge: true));
    } catch (e) {
      print("Failed to save answers: $e");
    }
  }
}

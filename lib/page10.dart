import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PertanyaanPage10 extends StatefulWidget {
  static String routeName = 'PertanyaanPage10';
  const PertanyaanPage10({super.key});

  @override
  _PertanyaanPage10State createState() => _PertanyaanPage10State();
}

class _PertanyaanPage10State extends State<PertanyaanPage10> {
  String? _selectedOption1;
  String? _selectedOption2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4F3FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE4F3FA),
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
                  '10 of 17',
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
              'Apakah kamu sering merasakan pusing atau terasa sakit di bagian kepala?',
              _selectedOption1,
              (value) {
                setState(() {
                  _selectedOption1 = value;
                });
              },
            ),
            const SizedBox(height: 18),
            _buildQuestionCard(
              'Apakah kamu sering mengalami tangan atau tubuh bergetar atau gemetar?',
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
                onPressed: () {
                  Navigator.pushNamed(context, 'PertanyaanPage11');
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
}

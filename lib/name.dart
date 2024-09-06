import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model_data_user.dart'; // Sesuaikan dengan nama file model data Anda

class NamePage extends StatefulWidget {
  static String routeName = 'NamePage';

  const NamePage({Key? key}) : super(key: key);

  @override
  _NamePageState createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameValid = true;

  void _validateName() {
    setState(() {
      _isNameValid = _nameController.text.isNotEmpty;
    });
  }

  Future<void> _saveName() async {
  _validateName();
  if (_isNameValid) {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String userId = currentUser.uid;
      userModel.setName(_nameController.text);

      try {
        await userModel.saveUserData(userId);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'GenderSelectionScreen');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving name: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not logged in.')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 360;

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png', // Path to your image asset
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20 * fem),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Siapakah Namamu?',
                          style: GoogleFonts.poppins(
                            fontSize: 28 * fem,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF004AAD),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20 * fem),
                        Container(
                          width: screenWidth * 0.85,
                          height: screenWidth * 0.14,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: _isNameValid ? Colors.blue : Colors.red,
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30 * fem),
                          ),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Masukkan nama anda',
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16 * fem,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30 * fem),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20 * fem, vertical: 15 * fem),
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 16 * fem,
                              color: const Color(0xFF004AAD),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 80 * fem),
                    child: ElevatedButton(
                      onPressed: _saveName, // Panggil metode yang menyimpan nama
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004AAD),
                        padding: EdgeInsets.symmetric(
                            horizontal: 110 * fem),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30 * fem),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lanjut',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 17 * fem,
                              ),
                            ),
                            SizedBox(width: 8 * fem),
                            Image.asset(
                              'assets/icons/arrow_icon.png', // Ganti dengan path ke gambar ikon
                              height:
                                  22.0 * fem, // Sesuaikan ukuran gambar ikon
                              width: 22.0 * fem, // Sesuaikan ukuran gambar ikon
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

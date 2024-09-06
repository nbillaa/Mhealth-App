import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model_data_user.dart';

class GenderSelectionScreen extends StatefulWidget {
  static String routeName = 'GenderSelectionScreen';

  const GenderSelectionScreen({super.key});

  @override
  _GenderSelectionScreenState createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender;
  bool _isGenderValid = true;

  void _validateGender() {
    setState(() {
      _isGenderValid = _selectedGender != null;
    });
  }

  Future<void> _saveGender() async {
    _validateGender();
    if (_isGenderValid) {
      final userModel = Provider.of<UserModel>(context, listen: false);
      final FirebaseAuth _auth = FirebaseAuth.instance;
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        String userId = currentUser.uid;
        userModel.setGender(_selectedGender!);

        try {
          await userModel.saveUserData(userId);
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, 'AgeSelection');
        } catch (e) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving gender: $e')),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Jenis Kelamin?',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF004AAD),
                      fontSize: 30 * fem,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30 * fem),
                  GenderCard(
                    gender: 'Laki-laki',
                    genderSymbol: Icons.male,
                    imagePath: 'assets/images/male.png',
                    isSelected: _selectedGender == 'Laki-laki',
                    onTap: () {
                      setState(() {
                        _selectedGender = 'Laki-laki';
                      });
                    },
                    isValid: _isGenderValid,
                    fem: fem,
                  ),
                  SizedBox(height: 30 * fem),
                  GenderCard(
                    gender: 'Perempuan',
                    genderSymbol: Icons.female,
                    imagePath: 'assets/images/female.png',
                    isSelected: _selectedGender == 'Perempuan',
                    onTap: () {
                      setState(() {
                        _selectedGender = 'Perempuan';
                      });
                    },
                    isValid: _isGenderValid,
                    fem: fem,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 80 * fem),
            child: Container(
              width: 320 * fem,
              child: ElevatedButton(
                onPressed: _saveGender,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  padding: EdgeInsets.symmetric(vertical: 14 * fem),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30 * fem),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17 * fem,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8 * fem),
                    Image.asset(
                      'assets/icons/arrow_icon.png',
                      height: 22.0 * fem,
                      width: 22.0 * fem,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String gender;
  final IconData genderSymbol;
  final String imagePath;
  final bool isSelected;
  final bool isValid;
  final VoidCallback onTap;
  final double fem;

  const GenderCard({
    super.key,
    required this.gender,
    required this.genderSymbol,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    required this.isValid,
    required this.fem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130 * fem,
        width: 320 * fem,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30 * fem),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.blue.withOpacity(0.5)
                  : !isValid && !isSelected
                      ? Colors.red.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.3),
              spreadRadius: 3 * fem,
              blurRadius: 5 * fem,
              offset: Offset(0, 3 * fem),
            ),
          ],
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(30 * fem),
              ),
            ),
            Positioned(
              top: 20 * fem,
              left: 20 * fem,
              child: Icon(genderSymbol, size: 30 * fem, color: const Color(0xFF004AAD)),
            ),
            Positioned(
              top: 20 * fem,
              left: 70 * fem,
              child: Text(
                gender,
                style: GoogleFonts.poppins(
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF004AAD),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model_data_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AgeSelection extends StatefulWidget {
  static String routeName = 'AgeSelection';
  const AgeSelection({Key? key}) : super(key: key);

  @override
  _AgeSelectionState createState() => _AgeSelectionState();
}

class _AgeSelectionState extends State<AgeSelection> {
  int selectedAge = 18;
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: selectedAge - 11);
  }

  Future<void> _saveAge() async {
    final userModel = Provider.of<UserModel>(context, listen: false);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;

    if (currentUser != null) {
      String userId = currentUser.uid;
      userModel.setAge(selectedAge);

      try {
        await userModel.saveUserData(userId);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'HomePage'); // Ganti dengan route yang sesuai
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving age: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is not logged in.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 360;

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: Column(
        children: [
          const Spacer(),
          Text(
            'Berapa Umurmu?',
            style: GoogleFonts.poppins(
              fontSize: 30 * fem,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF004AAD),
            ),
          ),
          SizedBox(height: 20 * fem),
          Expanded(
            flex: 3,
            child: ListWheelScrollView.useDelegate(
              controller: scrollController,
              itemExtent: 150 * fem,
              diameterRatio: 3.0,
              onSelectedItemChanged: (index) {
                setState(() {
                  selectedAge = 11 + index;
                });
              },
              physics: const FixedExtentScrollPhysics(),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  int age = 11 + index;
                  bool isSelected = age == selectedAge;
                  bool isNearSelected =
                      (age == selectedAge - 1 || age == selectedAge + 1);
                  bool isFarFromSelected =
                      (age == selectedAge - 2 || age == selectedAge + 2);

                  return Transform.scale(
                    scale: isSelected
                        ? 1.5
                        : isNearSelected
                            ? 1.2
                            : 1.0,
                    child: Center(
                      child: Container(
                        width: isSelected ? 200 * fem : 150 * fem,
                        height: isSelected ? 130 * fem : 70 * fem,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF9AC4E2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(70 * fem),
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xFFD3EADC),
                                  width: 2 * fem)
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '$age',
                            style: GoogleFonts.poppins(
                              fontSize: isSelected
                                  ? 90 * fem
                                  : isNearSelected
                                      ? 60 * fem
                                      : isFarFromSelected
                                          ? 30 * fem
                                          : 0,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : isNearSelected
                                      ? const Color(0xFFACA9A5)
                                      : Colors.grey[400],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: 10,
              ),
            ),
          ),
          SizedBox(height: 20 * fem),
          Padding(
            padding: EdgeInsets.only(bottom: 80 * fem),
            child: ElevatedButton(
              onPressed: _saveAge, // Panggil metode yang menyimpan umur
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF004AAD),
                padding: EdgeInsets.symmetric(horizontal: 120 * fem, vertical: 14 * fem),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30 * fem),
                ),
              ),
              child: Text(
                'Simpan',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18 * fem,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

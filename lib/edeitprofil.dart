import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'EditProfileScreen';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController(); // Controller untuk umur
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  void _loadUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          nameController.text = userDoc['name'] ?? '';
          ageController.text = userDoc['age']?.toString() ?? '';
          selectedGender = userDoc['gender'] ?? '';
        });
      }
    }
  }

  void _saveUserProfile() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'name': nameController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': selectedGender,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil disimpan')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define fem based on screen size
    double fem = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Profil',
          style: GoogleFonts.poppins(
            fontSize: 20 * fem,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004AAD),
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFFE3FBFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0 * fem, vertical: 20.0 * fem),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50 * fem,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 60 * fem, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20 * fem,
                        child: Icon(Icons.camera_alt, color: Colors.white, size: 20 * fem),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30 * fem),
                _buildProfileHeader('Nama', fem),
                SizedBox(height: 5 * fem),
                _buildNameInput(fem),
                SizedBox(height: 20 * fem),
                _buildProfileHeader('Umur', fem),
                SizedBox(height: 5 * fem),
                _buildAgeInput(fem),
                SizedBox(height: 20 * fem),
                _buildProfileHeader('Jenis Kelamin', fem),
                SizedBox(height: 5 * fem),
                _buildGenderDropdown(fem),
                SizedBox(height: 40 * fem),
                ElevatedButton(
                  onPressed: _saveUserProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004AAD),
                    padding: EdgeInsets.symmetric(horizontal: 140 * fem, vertical: 15 * fem),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15 * fem),
                    ),
                  ),
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.poppins(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(String label, double fem) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14 * fem,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF004AAD),
        ),
      ),
    );
  }

  Widget _buildNameInput(double fem) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0 * fem, vertical: 5.0 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3 * fem),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/name.png', width: 40 * fem, height: 40 * fem, fit: BoxFit.cover),
          SizedBox(width: 15 * fem),
          Expanded(
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama',
                border: InputBorder.none,
              ),
              style: GoogleFonts.poppins(
                fontSize: 16 * fem,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeInput(double fem) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0 * fem, vertical: 5.0 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3 * fem),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/age.png', width: 40 * fem, height: 40 * fem, fit: BoxFit.cover),
          SizedBox(width: 15 * fem),
          Expanded(
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: 'Masukkan umur',
                border: InputBorder.none,
                suffix: Padding(
                  padding: EdgeInsets.only(left: 2.0 * fem),
                  child: Text(
                    'Thn',
                    style: GoogleFonts.poppins(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              style: GoogleFonts.poppins(
                fontSize: 16 * fem,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(double fem) {
    List<String> genders = ['Laki-laki', 'Perempuan'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0 * fem, vertical: 5.0 * fem),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3 * fem),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/icons/gender.png', width: 40 * fem, height: 40 * fem, fit: BoxFit.cover),
          SizedBox(width: 15 * fem),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              value: selectedGender,
              items: genders.map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: GoogleFonts.poppins(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              )).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              dropdownColor: Colors.lightBlue[50],
            ),
          ),
        ],
      ),
    );
  }
}

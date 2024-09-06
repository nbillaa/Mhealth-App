import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  static String routeName = 'LoginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? _emailError;
  String? _passwordError;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

 Future<void> _signInWithEmailPassword() async {
  try {
    // Melakukan login dengan email dan password
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );

    // Mendapatkan pengguna saat ini
    User? user = userCredential.user;

    if (user != null) {
      // Mengambil dokumen pengguna dari Firestore berdasarkan UID
      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDocument.exists) {
        print('User document exists in Firestore.');

        var data = userDocument.data();
        if (data != null) {
          // Memeriksa apakah data identitas lengkap
          bool hasName = data.containsKey('name');
          bool hasGender = data.containsKey('gender');
          bool hasAge = data.containsKey('age');

          print('User data: $data');
          print('Has name: $hasName, Has gender: $hasGender, Has age: $hasAge');

          if (hasName && hasGender && hasAge) {
            // Data identitas lengkap, navigasi ke halaman beranda
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, 'HomePage');
          } else {
            // Data identitas tidak lengkap, navigasi ke halaman identitas
            Navigator.pushNamed(context, 'IdentitasPage');
          }
        } else {
          // Data dokumen null, navigasi ke halaman identitas
          Navigator.pushNamed(context, 'IdentitasPage');
        }
      } else {
        // Dokumen pengguna tidak ada, navigasi ke halaman identitas
        Navigator.pushNamed(context, 'IdentitasPage');
      }
    }
  } catch (e) {
    // Menangani error dan menampilkan pesan kesalahan
    print('Error during sign in: $e');
    setState(() {
      _emailError = 'Failed to sign in: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: 360 * fem,
                    height: 230 * fem,
                    child: Image.asset(
                      'assets/images/atas.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 200 * fem,
                  child: Padding(
                    padding: EdgeInsets.all(16.0 * fem),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20 * fem),
                          Text(
                            'Email Address',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF004AAD),
                              fontWeight: FontWeight.bold,
                              fontSize: 15 * fem,
                            ),
                          ),
                          SizedBox(height: 8 * fem),
                          Container(
                            height: 50 * fem,
                            padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: _emailError != null
                                      ? Colors.red.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                                if (_emailError == null &&
                                    _emailController.text.isNotEmpty)
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0 * fem),
                                  child: const Icon(Icons.email),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0 * fem),
                                errorStyle: const TextStyle(height: 0),
                                alignLabelWithHint: true,
                              ),
                              style: GoogleFonts.poppins(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _emailError = 'Please enter your email';
                                  });
                                  return '';
                                }
                                if (!value.contains('@')) {
                                  setState(() {
                                    _emailError = 'Please enter a valid email';
                                  });
                                  return '';
                                }
                                setState(() {
                                  _emailError = null;
                                });
                                return null;
                              },
                            ),
                          ),
                          if (_emailError != null)
                            Padding(
                              padding: EdgeInsets.only(top: 8.0 * fem),
                              child: Text(
                                _emailError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12 * fem),
                              ),
                            ),
                          SizedBox(height: 16 * fem),
                          Text(
                            'Password',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF004AAD),
                              fontWeight: FontWeight.bold,
                              fontSize: 15 * fem,
                            ),
                          ),
                          SizedBox(height: 8 * fem),
                          Container(
                            height: 50 * fem,
                            padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: _passwordError != null
                                      ? Colors.red.withOpacity(0.5)
                                      : Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                                if (_passwordError == null &&
                                    _passwordController.text.isNotEmpty)
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: !_passwordVisible,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.0 * fem),
                                  child: const Icon(Icons.lock),
                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 0,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.poppins(),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 15.0 * fem),
                                errorStyle: const TextStyle(height: 0),
                                alignLabelWithHint: true,
                              ),
                              style: GoogleFonts.poppins(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _passwordError =
                                        'Please enter your password';
                                  });
                                  return '';
                                }
                                if (value.length < 6) {
                                  setState(() {
                                    _passwordError =
                                        'Password must be at least 6 characters long';
                                  });
                                  return '';
                                }
                                setState(() {
                                  _passwordError = null;
                                });
                                return null;
                              },
                            ),
                          ),
                          if (_passwordError != null)
                            Padding(
                              padding: EdgeInsets.only(top: 8.0 * fem),
                              child: Text(
                                _passwordError!,
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12 * fem),
                              ),
                            ),
                          SizedBox(height: 30 * fem),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signInWithEmailPassword();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004AAD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30 * fem),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: 15.0 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Log In',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15 * fem,
                                    ),
                                  ),
                                  SizedBox(width: 8 * fem),
                                  Image.asset(
                                    'assets/icons/arrow_icon.png', // Ganti dengan path ke gambar ikon
                                    height: 22.0 *
                                        fem, // Sesuaikan ukuran gambar ikon
                                    width: 22.0 *
                                        fem, // Sesuaikan ukuran gambar ikon
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10 * fem),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'OR',
                                style: GoogleFonts.poppins(
                                  color:  const Color(0xFF004AAD),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15 * fem,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Login with Facebook
                                },
                                icon: Image.asset(
                                  'assets/icons/facebook.png',
                                  width: 40.0 * fem,
                                  height: 40.0 * fem,
                                ),
                                color: const Color(0xFF004AAD),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Login with Google
                                },
                                icon: Image.asset(
                                  'assets/icons/google.png',
                                  width: 40.0 * fem,
                                  height: 40.0 * fem,
                                ),
                                color: const Color(0xFF004AAD),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                // Navigate to signup page
                                Navigator.pushNamed(context, 'SignUpPage');
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'Belum punya akun? ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13 * fem,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Sign Up.',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF004AAD),
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                        fontSize: 13 * fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'LupaPasswordScreen');
                              },
                              child: Text(
                                'Forgot Password',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF004AAD),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13 * fem,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_app/authentication.dart'; // Import file authentication Anda

class SignUpPage extends StatefulWidget {
  static String routeName = 'SignUpPage';

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      String result = await AuthMethods().signUpUser(
        email: email,
        password: password,
        name: "Your Name", // Ganti dengan nama sebenarnya atau ambil dari field teks
      );
      if (result == "success") {
        // Setelah pendaftaran berhasil, arahkan ke halaman Login
        Navigator.pushNamed(context, 'LoginPage');
      } else {
        // Tampilkan pesan kesalahan jika pendaftaran gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
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
          child: Column(
            children: [
              SizedBox(
                width: 360 * fem,
                height: 230 * fem,
                child: Image.asset(
                  'assets/images/atas.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0 * fem),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Email Address',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF004AAD),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50 * fem,
                        padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _emailError != null
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                            if (_emailError == null && _emailController.text.isNotEmpty)
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
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(Icons.email),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.poppins(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF004AAD),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50 * fem,
                        padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _passwordError != null
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                            if (_passwordError == null && _passwordController.text.isNotEmpty)
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
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(Icons.lock),
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                            errorStyle: const TextStyle(height: 0),
                            alignLabelWithHint: true,
                          ),
                          style: GoogleFonts.poppins(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                _passwordError = 'Please enter your password';
                              });
                              return '';
                            }
                            if (value.length < 6) {
                              setState(() {
                                _passwordError = 'Password must be at least 6 characters long';
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
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        'Confirm Password',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF004AAD),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 50 * fem,
                        padding: EdgeInsets.symmetric(horizontal: 20 * fem),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _confirmPasswordError != null
                                  ? Colors.red.withOpacity(0.5)
                                  : Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                            if (_confirmPasswordError == null && _confirmPasswordController.text.isNotEmpty)
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_confirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirm your password',
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Icon(Icons.lock),
                            ),
                            prefixIconConstraints: const BoxConstraints(
                              minWidth: 0,
                              minHeight: 0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                            ),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.poppins(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                            errorStyle: const TextStyle(height: 0),
                            alignLabelWithHint: true,
                          ),
                          style: GoogleFonts.poppins(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              setState(() {
                                _confirmPasswordError = 'Please confirm your password';
                              });
                              return '';
                            }
                            if (value != _passwordController.text.trim()) {
                              setState(() {
                                _confirmPasswordError = 'Passwords do not match';
                              });
                              return '';
                            }
                            setState(() {
                              _confirmPasswordError = null;
                            });
                            return null;
                          },
                        ),
                      ),
                      if (_confirmPasswordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _confirmPasswordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004AAD),
                          padding: EdgeInsets.symmetric(vertical: 15 * fem),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            style: GoogleFonts.poppins(),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, 'LoginPage');
                            },
                            child: Text(
                              'Log In',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF004AAD),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

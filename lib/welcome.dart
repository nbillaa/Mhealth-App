import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MHealthHomePage extends StatelessWidget {
  static String routeName = 'MHealthHomePage';

  const MHealthHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width /
        360; // Menghitung faktor ukuran layar

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC), // Warna latar belakang khusus
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * fem),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo_biru.png',
                    height: 68.0 * fem), // Gambar logo di atas
                SizedBox(height: 10.0 * fem),
                RichText(
                  textAlign: TextAlign.center, // Teks rata tengah
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 26.0 * fem,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF004AAD), // Warna teks khusus
                      ),
                    ),
                    children: [
                      const TextSpan(text: 'Selamat datang di\n'),
                      TextSpan(
                        text: 'M-Health Detection!',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 26.0 *
                                fem, // Ukuran teks khusus untuk M-Health Detection
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF004AAD), // Warna teks khusus
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0 * fem),
                Text(
                  'M-Health akan membantu anda untuk mendeteksi gangguan mental sejak dini!✨',
                  textAlign: TextAlign.center, // Teks rata tengah
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16.0 * fem,
                      color: const Color(0xFF736B66), // Warna teks khusus
                    ),
                  ),
                ),
                SizedBox(height: 25.0 * fem),
                Image.asset('assets/images/robot.png',
                    height: 300.0 * fem), // Gambar robot
                SizedBox(
                    height: 50.0 *
                        fem), // Menambahkan jarak lebih besar untuk tombol
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'DisclaimerPage');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 50.0 * fem, vertical: 15.0 * fem),
                    backgroundColor:
                        const Color(0xFF004AAD), // Warna tombol khusus
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(30.0), // Kelengkungan tombol
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mulai',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0 * fem,
                          color: Colors.white, // Menambahkan warna putih
                        ),
                      ), // Teks dengan font Poppins
                      SizedBox(
                          width: 8.0 * fem), // Jarak antara teks dan gambar
                      Image.asset(
                        'assets/icons/arrow_icon.png', // Ganti dengan path ke gambar ikon
                        height: 20.0 * fem, // Sesuaikan ukuran gambar ikon
                        width: 20.0 * fem, // Sesuaikan ukuran gambar ikon
                      ),
                    ],
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

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MHealthHomePage(),
  ));
}

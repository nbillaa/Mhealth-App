import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreens extends StatefulWidget {
  const PrivacyScreens({super.key});
  static String routeName = 'PrivacyScreen';

  @override
  State<PrivacyScreens> createState() => _PrivacyScreensState();
}

class _PrivacyScreensState extends State<PrivacyScreens> {

  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar saat ini
    final screenSize = MediaQuery.of(context).size;
    final fem = screenSize.width / 375; // Asumsikan 375 sebagai lebar standar untuk perhitungan skala
    final fontFem = fem * 0.97; // Skala tambahan untuk font

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004AAD), size: 24 * fem),
          onPressed: () {
            Navigator.pushNamed(context, 'SettingsScreen');
          },
        ),
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        title: Text(
          'Kebijakan Privasi',
          style: GoogleFonts.poppins(
            fontSize: 20 * fontFem,
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
                Center(
                  child: Container(
                    width: 320 * fem,
                    height: 300 * fem,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/privasi.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30 * fem),
                _buildPrivacySection(
                  context,
                  "Pengumpulan Informasi",
                  "Kami akan mengumpulkan informasi pribadi dari pengguna saat mereka mendaftar dan menggunakan aplikasi kami.",
                  "assets/icons/pp1.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildPrivacySection(
                  context,
                  "Penggunaan Informasi",
                  "Informasi yang dikumpulkan digunakan untuk menyediakan dan mengelola layanan aplikasi, menganalisis data untuk memberikan hasil deteksi dini gangguan mental.",
                  "assets/icons/pp2.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildPrivacySection(
                  context,
                  "Keamanan Informasi",
                  "Kami mengambil langkah-langkah yang wajar untuk melindungi informasi Anda dari akses, penggunaan, atau pengungkapan yang tidak sah.",
                  "assets/icons/pp3.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildPrivacySection(
                  context,
                  "Pengungkapan Informasi",
                  "Kami tidak akan membagikan informasi pribadi pengguna kami kepada pihak ketiga tanpa izin dari pengguna, kecuali dalam kasus dimana kami diwajibkan oleh hukum untuk melakukannya.",
                  "assets/icons/pp4.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildPrivacySection(
                  context,
                  "Akses, Perbaikan, dan Penghapusan Informasi",
                  "Pengguna dapat mengakses, memperbarui atau menghapus informasi pribadi mereka dengan menghubungi kami melalui kontak yang tersedia di aplikasi kami.",
                  "assets/icons/pp5.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
                SizedBox(height: 20 * fem),
                _buildPrivacySection(
                  context,
                  "Perubahan pada Kebijakan Privasi",
                  "Kami berhak untuk mengubah kebijakan privasi kami setiap saat tanpa pemberitahuan sebelumnya. Pengguna disarankan untuk memeriksa kebijakan privasi kami secara berkala.",
                  "assets/icons/pp6.png",
                  fem: fem,
                  fontFem: fontFem,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySection(
    BuildContext context, 
    String title, 
    String content, 
    String imagePath, 
    { 
      required double fem, 
      required double fontFem,
    }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20 * fem),
      ),
      padding: EdgeInsets.all(15.0 * fem),
      child: Row(
        children: [
          Container(
            width: 40 * fem,
            height: 40 * fem,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10 * fem),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF004AAD),
                    fontWeight: FontWeight.w600,
                    fontSize: 15 * fontFem,
                  ),
                ),
                SizedBox(height: 5 * fem),
                Text(
                  content,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF004AAD),
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * fontFem,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

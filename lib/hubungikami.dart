import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HubungiKami extends StatefulWidget {
  const HubungiKami({super.key});
  static String routeName = 'HubungiKami';

  @override
  State<HubungiKami> createState() => _HubungiKamiState();
}

class _HubungiKamiState extends State<HubungiKami> {

  @override
  Widget build(BuildContext context) {
    // Dapatkan ukuran layar saat ini
    final screenSize = MediaQuery.of(context).size;
    final fem = screenSize.width / 375; // Asumsikan 375 sebagai lebar standar untuk perhitungan skala
    final fontFem = fem * 0.97; // Skala tambahan untuk font

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004AAD), size: 24 * fem),
          onPressed: () {
            Navigator.pushNamed(context, 'SettingsScreen');
          },
        ),
        title: Text(
          'Hubungi Kami',
          style: GoogleFonts.poppins(
            fontSize: 20 * fontFem,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004AAD),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0 * fem, vertical: 20.0 * fem),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 325 * fem,
                        height: 320 * fem,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/robothub.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30 * fem),
                    _buildPrivacySection(
                      context,
                      "+6282293320943",
                      "(Nabila)",
                      "assets/icons/whatsapp.png",
                      fem: fem,
                      fontFem: fontFem,
                      isPhoneNumber: true,
                    ),
                    SizedBox(height: 18 * fem),
                    _buildPrivacySection(
                      context,
                      "bila08293@gmail.com",
                      "(Nabila)",
                      "assets/icons/email.png",
                      fem: fem,
                      fontFem: fontFem,
                      isEmail: true,
                    ),
                  ],
                ),
              ),
            ],
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
      bool isPhoneNumber = false, 
      bool isEmail = false,
    }) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25 * fem),
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
                      fontSize: 17 * fontFem,
                    ),
                  ),
                  SizedBox(height: 5 * fem),
                  Text(
                    content,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF004AAD),
                      fontWeight: FontWeight.w600,
                      fontSize: 16 * fontFem,
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

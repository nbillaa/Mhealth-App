import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HasilDeteksi extends StatelessWidget {
  static String routeName = 'HasilDeteksi';

  const HasilDeteksi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        title: Text(
          'Hasil Deteksi Dini',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004AAD),
          ),
        ),
        centerTitle: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgresult.png'), // Sesuaikan path gambar
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '93%',
                    style: GoogleFonts.poppins(
                      fontSize: 110,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF004AAD),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0), // Mengurangi jarak antara teks "93%" dan "Depresi"
                    child: Text(
                      'Depresi',
                      style: GoogleFonts.poppins(
                        fontSize:50,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF004AAD),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100), // Menurunkan indikator lebih jauh ke bawah
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        Container(
                          width: constraints.maxWidth * 0.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004AAD),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 40), // Menurunkan teks lebih jauh ke bawah
              Text(
                'Lihat detail',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF004AAD),
                ),
              ),
              const SizedBox(height: 60), // Menurunkan tombol lebih jauh ke bawah
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'DetailPenyakitPage');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

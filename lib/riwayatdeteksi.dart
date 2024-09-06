import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RiwayatDeteksi extends StatefulWidget {
  const RiwayatDeteksi({super.key});
  static String routeName = 'RiwayatDeteksi';

  @override
  State<RiwayatDeteksi> createState() => _RiwayatDeteksiState();
}

class _RiwayatDeteksiState extends State<RiwayatDeteksi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Riwayat Deteksi',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF004AAD),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 255,
                    height: 340,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/robotriwayat.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Riwayat Deteksi Kosong!!",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF004AAD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, 
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
        selectedItemColor: const Color(0xFF004AAD),
        unselectedItemColor: Colors.grey, // Color for unselected items
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, 'HomePage');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, 'RiwayatDeteksi');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, 'ProfileScreen');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, 'SettingsScreen');
              break;
          }
        },
      ),
    );
  }
}

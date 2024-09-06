import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'model_data_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'HomePage';
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserModel userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Mendapatkan ID pengguna yang sedang login
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userModel = Provider.of<UserModel>(context, listen: false);

      // Memuat data pengguna jika belum dimuat
      if (userModel.name.isEmpty && userModel.gender.isEmpty && userModel.age == 0) {
        userModel.loadUserDataAfterLogin(user.uid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double fem = screenWidth / 360; // Menghitung faktor ukuran layar

    return Scaffold(
      backgroundColor: const Color(0xFFE3FBFC),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background2.png',
                  fit: BoxFit.cover,
                ),
              ),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0 * fem),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30 * fem,
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person,
                                  size: 40 * fem, color: Colors.white),
                            ),
                            SizedBox(width: 20 * fem),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${userModel.name}', // Gunakan nama dari model
                                  style: GoogleFonts.poppins(
                                    fontSize: 23 * fem,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF004AAD),
                                  ),
                                ),
                                Text(
                                  'Ayok cek kesehatan mental anda\ndengan M-Health Detection!!',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5 * fem,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20 * fem),
                        Center(
                          child: Image.asset(
                            'assets/images/robot2.png',
                            height: 300 * fem,
                          ),
                        ),
                        SizedBox(height: 20 * fem),
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: 310 * fem, // Lebar tombol yang tetap
                                height: 80 * fem, // Tinggi tombol yang tetap
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'Tahap1Page');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF004AAD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Deteksi Dini Penyakit Mental',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16 * fem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20 * fem),
                              SizedBox(
                                width: 310 * fem, // Lebar tombol yang tetap
                                height: 80 * fem, // Tinggi tombol yang tetap
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'RiwayatDeteksi');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF004AAD),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Riwayat Hasil Deteksi',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16 * fem,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'HomePage');
              break;
            case 1:
              Navigator.pushNamed(context, 'RiwayatDeteksi');
              break;
            case 2:
              Navigator.pushNamed(context, 'ProfileScreen');
              break;
            case 3:
              Navigator.pushNamed(context, 'SettingsScreen');
              break;
          }
        },
      ),
    );
  }
}

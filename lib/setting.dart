import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'model_data_user.dart'; 

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static String routeName = 'SettingsScreen';

  @override
  Widget build(BuildContext context) {
    final fem = MediaQuery.of(context).size.width / 375; // Unit fem untuk responsivitas
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF004AAD), size: 24 * fem),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        title: Text(
          'Pengaturan',
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
            padding: EdgeInsets.symmetric(horizontal: 20 * fem, vertical: 20 * fem),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30 * fem,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, size: 40 * fem, color: Colors.white),
                    ),
                    SizedBox(width: 20 * fem),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name, // Ambil nama dari model
                          style: GoogleFonts.poppins(
                            fontSize: 18 * fem,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF004AAD),
                          ),
                        ),
                        Text(
                          '${userModel.age} Tahun', // Ambil umur dari model
                          style: GoogleFonts.poppins(
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20 * fem),
                SectionHeader(title: 'Riwayat saya', fem: fem),
                SizedBox(height: 15 * fem),
                SettingsItem(
                  icon: Icons.history,
                  title: 'Riwayat Deteksi',
                  fem: fem,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'RiwayatDeteksi');
                  },
                ),
                SizedBox(height: 20 * fem),
                SectionHeader(title: 'M-Health Detection', fem: fem),
                SizedBox(height: 15 * fem),
                SettingsItem(
                  icon: Icons.info,
                  title: 'Tentang Kami',
                  fem: fem,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'TentangKami');
                  },
                ),
                SizedBox(height: 15 * fem),
                SettingsItem(
                  icon: Icons.help,
                  title: 'Bantuan',
                  fem: fem,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'FAQScreen');
                  },
                ),
                SizedBox(height: 15 * fem),
                SettingsItem(
                  icon: Icons.phone,
                  title: 'Hubungi Kami',
                  fem: fem,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'HubungiKami');
                  },
                ),
                SizedBox(height: 15 * fem),
                SettingsItem(
                  icon: Icons.privacy_tip,
                  title: 'Privasi',
                  fem: fem,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'PrivacyScreen');
                  },
                ),
                SizedBox(height: 25 * fem),
                SettingsItem(
                  icon: Icons.logout,
                  title: 'Log Out',
                  fem: fem,
                  onTap: () {
                    _showLogoutConfirmationDialog(context, fem);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // Ensure this is the index for the SettingsScreen
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

  void _showLogoutConfirmationDialog(BuildContext context, double fem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Konfirmasi Logout',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFFCB3F41),
              fontSize: 20 * fem,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar dari akun ini?',
            style: GoogleFonts.poppins(fontSize: 15 * fem, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog jika pengguna memilih "Tidak"
              },
              child: Text(
                'Tidak',
                style: GoogleFonts.poppins(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF004AAD),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final userModel = Provider.of<UserModel>(context, listen: false);
                  userModel.resetData(); // Reset data sebelum logout
                  await FirebaseAuth.instance.signOut(); // Logout dari Firebase
                  await Future.delayed(const Duration(seconds: 1)); // Tunggu sebentar
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, 'LoginPage'); // Kembali ke halaman login
                } catch (e) {
                  print('Error signing out: $e');
                }
              },
              child: Text(
                'Ya',
                style: GoogleFonts.poppins(
                  fontSize: 16 * fem,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFCB3F41),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final double fem;

  const SectionHeader({super.key, required this.title, required this.fem});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 17 * fem,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF004AAD),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double fem;
  final VoidCallback onTap;

  const SettingsItem({super.key, 
    required this.icon,
    required this.title,
    required this.fem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.0 * fem, horizontal: 20.0 * fem),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20 * fem),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF004AAD), size: 24 * fem),
            SizedBox(width: 20 * fem),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 17 * fem,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF004AAD),
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: const Color(0xFF004AAD), size: 16 * fem),
          ],
        ),
      ),
    );
  }
}

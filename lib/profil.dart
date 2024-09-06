import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_app/model_data_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;

      userModel = Provider.of<UserModel>(context);
      
      if (userModel.name.isEmpty && userModel.gender.isEmpty && userModel.age == 0) {
        userModel.loadUserDataAfterLogin(userId).then((_) {
          setState(() {});
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fem = MediaQuery.of(context).size.width / 375; // Unit fem untuk responsif
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background3.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: user.name.isEmpty && user.gender.isEmpty && user.age == 0
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 100 * fem, left: 20 * fem, right: 20 * fem),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 60 * fem,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.person, size: 80 * fem, color: Colors.blue),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, 'EditProfileScreen').then((_) {
                                        userModel.loadUserDataAfterLogin(FirebaseAuth.instance.currentUser!.uid).then((_) {
                                          setState(() {});
                                        });
                                      });
                                    },
                                    child: Image.asset(
                                      'assets/icons/Edit_duotone.png',
                                      width: 40 * fem,
                                      height: 40 * fem,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20 * fem),
                            Text(
                              'Info Profil',
                              style: GoogleFonts.poppins(
                                fontSize: 24 * fem,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF004AAD),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20 * fem),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20 * fem, vertical: 10 * fem),
                          children: [
                            _buildProfileItem('Nama', user.name, fem),
                            _buildProfileItem('Jenis Kelamin', user.gender, fem),
                            _buildProfileItem('Umur', '${user.age} Tahun', fem),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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

  Widget _buildProfileItem(String title, String value, double fem) {
    return Container(
      margin: EdgeInsets.only(bottom: 20 * fem),
      padding: EdgeInsets.all(15 * fem),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20 * fem),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2 * fem,
            blurRadius: 5 * fem,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16 * fem,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF004AAD),
            ),
          ),
          SizedBox(height: 5 * fem),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16 * fem,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF004AAD),
            ),
          ),
        ],
      ),
    );
  }
}

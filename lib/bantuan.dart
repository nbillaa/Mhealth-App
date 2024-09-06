import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});
  static String routeName = 'FAQScreen';

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF004AAD)),
          onPressed: () {
            Navigator.pushNamed(context, 'SettingsScreen');
          },
        ),
        backgroundColor: const Color(0xFFE3FBFC),
        elevation: 0,
        title: Text(
          'Bantuan',
          style: GoogleFonts.poppins(
            fontSize: 20,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "FAQ",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004AAD),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Column(
                  children: _data.map<Widget>((Item item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        title: Text(
                          item.headerValue,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF004AAD),
                          ),
                        ),
                        childrenPadding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 10.0,
                        ),
                        iconColor: const Color(0xFF004AAD),
                        textColor: const Color(0xFF004AAD),
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF004AAD),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                item.expandedValue,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
  });

  final String expandedValue;
  final String headerValue;
}

List<Item> generateItems() {
  return <Item>[
    Item(
      headerValue: 'Apa tujuan dari M-Health Detection?',
      expandedValue: 'Aplikasi ini dirancang untuk membantu mendeteksi tanda-tanda awal gangguan mental pada remaja dengan menggunakan kombinasi algoritma XGBoost dan metode forward chaining.',
    ),
    Item(
      headerValue: 'Bagaimana cara kerja aplikasi ini?',
      expandedValue: 'Pengguna akan diminta untuk menjawab serangkaian pertanyaan mengenai gejala yang dialami. Berdasarkan jawaban tersebut, algoritma XGBoost dan metode forward chaining akan menganalisis data dan memberikan hasil deteksi awal.',
    ),
    Item(
      headerValue: 'Apakah hasil dari aplikasi ini akurat?',
      expandedValue: 'Hasil yang diberikan adalah indikasi awal berdasarkan data yang telah dimasukkan. Untuk diagnosis yang lebih akurat, disarankan untuk berkonsultasi dengan profesional kesehatan mental.',
    ),
    Item(
      headerValue: 'Apakah data saya aman?',
      expandedValue: 'Ya, kami berkomitmen untuk menjaga privasi dan keamanan data pengguna. Informasi lebih lanjut mengenai kebijakan privasi kami dapat ditemukan di halaman Kebijakan Privasi.',
    ),
    Item(
      headerValue: 'Apakah aplikasi ini dapat menggantikan profesional kesehatan mental?',
      expandedValue: 'Tidak, aplikasi ini hanya alat bantu untuk deteksi dini dan tidak menggantikan diagnosis atau perawatan dari profesional kesehatan mental.',
    ),
    Item(
      headerValue: 'Bagaimana cara mendapatkan bantuan teknis jika mengalami masalah dengan aplikasi?',
      expandedValue: 'Jika Anda mengalami masalah teknis, Anda dapat menghubungi tim dukungan kami dengan mengakses page Hubungi Kami pada aplikasi ini.',
    ),
    Item(
      headerValue: 'Bisakah saya menggunakan aplikasi ini untuk memantau kesehatan mental jangka panjang?',
      expandedValue: 'Aplikasi ini dirancang untuk deteksi awal dan tidak dimaksudkan untuk pemantauan jangka panjang. Sebaiknya konsultasikan hasilnya dengan profesional kesehatan mental untuk tindak lanjut yang lebih tepat.',
    ),
  ];
}

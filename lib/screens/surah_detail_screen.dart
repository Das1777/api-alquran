import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher
import '../models/surah.dart';

class SurahDetailScreen extends StatelessWidget {
  final Surah surah;

  SurahDetailScreen({required this.surah});

  // Function to open the URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(surah.nama, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 10, // Tambahkan elevasi untuk memberikan bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Tambahkan border radius untuk membuat sudut-sudutnya tidak tajam
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Surah: ${surah.nama} (${surah.namaLatin})', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      SizedBox(height: 10),
                      Text('Jumlah Ayat: ${surah.jumlahAyat}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text('Tempat Turun: ${surah.tempatTurun}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text('Arti: ${surah.arti}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 20),
                      Text('Deskripsi:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text(surah.deskripsi, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => _launchURL(surah.audio), // Handle the URL click
                        child: Text(
                          'Audio URL: ${surah.audio}',
                          style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(height: 20), // Tambahkan jarak untuk logo Quran
                      // Tidak ada gambar dalam box karena instruksi untuk membuat gambar keluar box
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Tambahkan jarak untuk mengurangi kesan dekat dengan box
              // Gambar Quran di luar box
              Image.asset('assets/alquran.png'), // Tambahkan logo Quran di luar box
            ],
          ),
        ),
      ),
    );
  }
}

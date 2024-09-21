import 'package:flutter/material.dart';
import 'screens/surah_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Surah List',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SurahListScreen(),
      debugShowCheckedModeBanner: false, // Tidak menampilkan logo debug
    );
  }
}


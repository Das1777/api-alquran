import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../services/api_service.dart';
import 'surah_detail_screen.dart'; // Import the detail screen

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({Key? key}) : super(key: key);

  @override
  _SurahListScreenState createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late Future<List<Surah>> futureSurahList;
  final ApiService apiService = ApiService();
  List<Surah> _surahList = [];
  List<Surah> _filteredSurahList = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureSurahList = apiService.fetchSurahList();
    futureSurahList.then((list) {
      setState(() {
        _surahList = list;
        _filteredSurahList = list; // Initialize filtered list
      });
    });
  }

  void _filterSurahList(String query) {
    List<Surah> filteredList = _surahList.where((surah) {
      return surah.nama.toLowerCase().contains(query.toLowerCase()) ||
          surah.namaLatin.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredSurahList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Cari Surah...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      _filterSurahList('');
                    },
                  ),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: _filterSurahList, // Call the search function
              )
            : Text('AL QURAN', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _filteredSurahList = _surahList; // Reset list
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Surah>>(
        future: futureSurahList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red)));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: _filteredSurahList.length,
              itemBuilder: (context, index) {
                Surah surah = _filteredSurahList[index];
                return Card(
                  elevation: 10,
                  margin: EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.book_online, color: Colors.green, size: 32),
                    title: Text('${surah.nomor}: ${surah.nama}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(surah.namaLatin,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    trailing: Text('${surah.jumlahAyat} Ayat',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    onTap: () {
                      // Navigate to the detail screen when the list tile is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SurahDetailScreen(surah: surah),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text('Tidak ada data',
                    style: TextStyle(fontSize: 18, color: Colors.grey)));
          }
        },
      ),
    );
  }
}

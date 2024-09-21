import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah.dart';

class ApiService {
  static const String baseUrl = 'https://quran-api.santrikoding.com/api/surah';

  Future<List<Surah>> fetchSurahList() async {
    final response = await http.get(Uri.parse(baseUrl));
    print(response);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Surah.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Surah list');
    }
  }
}

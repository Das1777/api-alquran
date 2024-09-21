import 'package:flutter/material.dart';
import '../models/surah.dart';

class SurahListTile extends StatelessWidget {
  final Surah surah;

  const SurahListTile({Key? key, required this.surah}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${surah.nomor ?? '-'}: ${surah.nama ?? 'Tidak diketahui'}'),
      subtitle: Text(surah.namaLatin ?? 'Tidak diketahui'),
      trailing: Text('${surah.jumlahAyat ?? 0} Ayat'),
    );
  }
}

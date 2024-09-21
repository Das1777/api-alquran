class Surah {
  final int nomor;
  final String nama;
  final String namaLatin;
  final int jumlahAyat;
  final String tempatTurun;
  final String arti;
  final String deskripsi;
  final String audio;

  Surah({
    required this.nomor,
    required this.nama,
    required this.namaLatin,
    required this.jumlahAyat,
    required this.tempatTurun,
    required this.arti,
    required this.deskripsi,
    required this.audio,
  });

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      nomor: json['nomor'] ?? 0,
      nama: json['nama'] ?? 'Tidak diketahui',
      namaLatin: json['nama_latin'] ?? 'Tidak diketahui',
      jumlahAyat: json['jumlah_ayat'] ?? 0,
      tempatTurun: json['tempat_turun'] ?? 'Tidak diketahui',
      arti: json['arti'] ?? 'Tidak diketahui',
      deskripsi: json['deskripsi'] ?? 'Tidak diketahui',
      audio: json['audio'] ?? 'Tidak diketahui',
    );
  }
}

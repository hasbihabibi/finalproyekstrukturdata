import 'dart:io';

class CSVService {
  final String filePath = 'data/pengiriman.csv';
  List<String> bacaData() {
    File file = File(filePath);

    if (!file.existsSync()) {
      print('File tidak ditemukan: $filePath');
      return [];
    }
    return file.readAsLinesSync();
  }

  void simpanData(List<String> rows) {
    File file = File(filePath);
    file.writeAsStringSync(rows.join('\n'));

    print('Data berhasil disimpan ke $filePath');
  }
}

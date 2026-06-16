import '../models/pengiriman.dart';
import '../structures/stack.dart';
import '../structures/queue.dart';
import 'csv_service.dart';
import 'dart:io';
import '../models/tomat.dart';
import '../models/jagung.dart';
import '../models/beras.dart';
import '../models/komoditas.dart';
import '../enums/status_pengiriman.dart';

class PengirimanService {
  List<Pengiriman> daftarPengiriman = [];
  Queue<Pengiriman> antrean = Queue();
  Stack<Pengiriman> undoStack = Stack();
  CSVService csvService = CSVService();

  void loadCSV() {
    List<String> rows = csvService.bacaData();

    for (int i = 1; i < rows.length; i++) {
      List<String> kolom = rows[i].split(',');

      Pengiriman p = Pengiriman.fromCsv(kolom);

      daftarPengiriman.add(p);

      antrean.enqueue(p);
    }

    print("${daftarPengiriman.length} data berhasil dimuat.");
  }

  void simpanCSV() {
    List<String> rows = [];

    rows.add('id,komoditas,grade,berat,tujuan,status');

    for (var p in daftarPengiriman) {
      rows.add(p.toCsv());
    }

    csvService.simpanData(rows);
  }

  void tampilkanSemua() {
    if (daftarPengiriman.isEmpty) {
      print("Tidak ada data.");
      return;
    }

    for (var p in daftarPengiriman) {
      print(p);
      print("----------------");
    }
  }

  Pengiriman? cariPengiriman(int id) {
    for (var p in daftarPengiriman) {
      if (p.id == id) {
        return p;
      }
    }

    return null;
  }

  void tambahPengiriman(Pengiriman p) {
    daftarPengiriman.add(p);
    antrean.enqueue(p);
    undoStack.push(p);
    simpanCSV();
    print("Pengiriman dengan ID ${p.id} berhasil ditambahkan.");
  }

  void undo() {
    Pengiriman? terakhir = undoStack.pop();

    if (terakhir == null) {
      print("Tidak ada data untuk dibatalkan.");
      return;
    }
    daftarPengiriman.remove(terakhir);
    simpanCSV();
    print("Pengiriman dengan ID ${terakhir.id} berhasil dibatalkan.");
  }

  void prosesAntrean() {
    Pengiriman? p = antrean.dequeue();

    if (p == null) {
      print("Tidak ada antrean untuk diproses.");
      return;
    }

    p.status = StatusPengiriman.diproses;

    simpanCSV();

    print("Pengiriman dengan ID ${p.id} sedang diproses.");
  }

  void inputPengirimanBaru() {
    print('ID Pengiriman:');

    int id = int.parse(stdin.readLineSync()!);
    if (cariPengiriman(id) != null) {
      print('ID sudah digunakan.');
      return;
    }

    print('Komoditas (Jagung/Beras/Tomat):');

    String namaKomoditas = stdin.readLineSync()!;

    print('Grade:');

    String grade = stdin.readLineSync()!;

    print('Berat (kg):');

    double berat = double.parse(stdin.readLineSync()!);

    print('Tujuan:');

    String tujuan = stdin.readLineSync()!;

    Komoditas komoditas;

    switch (namaKomoditas.toLowerCase()) {
      case 'jagung':
        komoditas = Jagung(berat, grade);

        break;

      case 'beras':
        komoditas = Beras(berat, grade);

        break;

      case 'tomat':
        komoditas = Tomat(berat, grade);

        break;

      default:
        print('Komoditas tidak valid');

        return;
    }

    Pengiriman p = Pengiriman(
      id: id,
      komoditas: komoditas,
      tujuan: tujuan,
      status: StatusPengiriman.menunggu,
    );

    print('\nData yang ditambahkan:');
    print(p);

    tambahPengiriman(p);
  }

  void updateStatusPengiriman() {
    print('Masukkan ID Pengiriman:');

    int id = int.parse(stdin.readLineSync()!);

    Pengiriman? p = cariPengiriman(id);

    if (p == null) {
      print('Pengiriman tidak ditemukan.');
      return;
    }

    print('''
Pilih Status Baru:

1. Menunggu
2. Diproses
3. Dikirim
4. Selesai
''');

    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        p.status = StatusPengiriman.menunggu;
        break;

      case '2':
        p.status = StatusPengiriman.diproses;
        break;

      case '3':
        p.status = StatusPengiriman.dikirim;
        break;

      case '4':
        p.status = StatusPengiriman.selesai;
        break;

      default:
        print('Pilihan tidak valid.');
        return;
    }

    simpanCSV();

    print(
      'Status pengiriman ID ${p.id} berhasil diubah menjadi ${p.status.name}.',
    );
  }
}

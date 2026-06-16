import '../lib/utils/menu.dart';
import '../lib/services/pengiriman_service.dart';
import 'dart:io';

void main() {
  PengirimanService service = PengirimanService();
  service.loadCSV();

  while (true) {
    tampilkanMenu();

    String? pilih = stdin.readLineSync();

    switch (pilih) {
      case '1':
        service.tampilkanSemua();
        break;

      case '2':
        print('Masukkan ID:');
        String? input = stdin.readLineSync();

        int? id = int.tryParse(input ?? '');

        if (id == null) {
          print("ID tidak valid.");
          break;
        }

        var hasil = service.cariPengiriman(id);
        if (hasil != null) {
          print(hasil);
        } else {
          print("Pengiriman dengan ID $id tidak ditemukan.");
        }
        break;

      case '3':
        service.prosesAntrean();
        break;

      case '4':
        service.undo();
        break;

      case '5':
        service.inputPengirimanBaru();
        break;

      case '6':
        service.updateStatusPengiriman();
        break;

      case '0':
        print("Terima kasih telah menggunakan Tani Makmur.");
        return;

      default:
        print("Pilihan tidak valid.");
    }
  }
}

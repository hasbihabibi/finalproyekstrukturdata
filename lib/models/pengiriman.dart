import '../interfaces/dapat_dilacak.dart';
import '../enums/status_pengiriman.dart';
import 'komoditas.dart';
import 'jagung.dart';
import 'beras.dart';
import 'tomat.dart';

class Pengiriman implements DapatDilacak {
  int id;
  Komoditas komoditas;
  String tujuan;
  StatusPengiriman status;
  Pengiriman({
    required this.id,
    required this.komoditas,
    required this.tujuan,
    required this.status,
  });

  String toCsv() {
    return "$id,${komoditas.nama},${komoditas.grade},${komoditas.berat},$tujuan,${status.name}";
  }

  @override
  void lacakPengiriman() {
    print("Melacak pengiriman dengan ID: $id");
    print("Status saat ini: ${status.name}");
  }

  factory Pengiriman.fromCsv(List<String> data) {
    Komoditas komoditas;

    switch (data[1].toLowerCase()) {
      case 'jagung':
        komoditas = Jagung(double.parse(data[3]), data[2]);
        break;

      case 'beras':
        komoditas = Beras(double.parse(data[3]), data[2]);
        break;

      case 'tomat':
        komoditas = Tomat(double.parse(data[3]), data[2]);
        break;

      default:
        throw Exception('Komoditas tidak dikenal');
    }

    StatusPengiriman status;

    switch (data[5].toLowerCase()) {
      case 'menunggu':
        status = StatusPengiriman.menunggu;
        break;

      case 'diproses':
        status = StatusPengiriman.diproses;
        break;

      case 'dikirim':
        status = StatusPengiriman.dikirim;
        break;

      case 'selesai':
        status = StatusPengiriman.selesai;
        break;

      default:
        throw Exception('Status tidak dikenal');
    }

    return Pengiriman(
      id: int.parse(data[0]),
      komoditas: komoditas,
      tujuan: data[4],
      status: status,
    );
  }

  @override
  String toString() {
    return '''
ID        : $id
Komoditas : ${komoditas.nama}
Grade     : ${komoditas.grade}
Berat     : ${komoditas.berat} kg
Tujuan    : $tujuan
Status    : ${status.name}
''';
  }
}

import 'komoditas.dart';

class Beras extends Komoditas {
  Beras(double berat, String grade) : super('Beras', berat, grade);

  @override
  void tampilkanInfo() {
    print('$nama - Grade $grade');
  }
}

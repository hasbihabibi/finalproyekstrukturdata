import 'komoditas.dart';

class Jagung extends Komoditas {
  Jagung(double berat, String grade) : super('Jagung', berat, grade);

  @override
  void tampilkanInfo() {
    print('$nama - Grade $grade');
  }
}

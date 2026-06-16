import 'komoditas.dart';

class Tomat extends Komoditas {
  Tomat(double berat, String grade) : super('Tomat', berat, grade);

  @override
  void tampilkanInfo() {
    print('$nama - Grade $grade');
  }
}

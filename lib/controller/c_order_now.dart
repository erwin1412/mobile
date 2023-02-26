import 'package:get/get.dart';

class COrderNow extends GetxController {
  final RxString _ekspedisi = 'JNE'.obs;
  final RxString _pembayaran = 'BCA'.obs;

  String get ekspedisi => _ekspedisi.value;
  String get pembayaran => _pembayaran.value;

  setEkspedisi(String newEkspedisi) => _ekspedisi.value = newEkspedisi;
  setPembayaran(String newPembayaran) => _pembayaran.value = newPembayaran;
}

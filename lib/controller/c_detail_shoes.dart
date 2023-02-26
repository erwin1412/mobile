import 'package:get/get.dart';

class CDetailShoes extends GetxController {
  final RxBool _isFavorite = false.obs;
  final RxInt _quantity = 1.obs;
  final RxInt _size = 0.obs;
  final RxInt _color = 0.obs;

  bool get isFavorite => _isFavorite.value;
  int get quantity => _quantity.value;
  int get size => _size.value;
  int get color => _color.value;

  setIsWhislist(bool newIsWhislist) => _isFavorite.value = newIsWhislist;
  setQuantity(int newQuantity) => _quantity.value = newQuantity;
  setSize(int newSize) => _size.value = newSize;
  setColor(int newColor) => _color.value = newColor;
}

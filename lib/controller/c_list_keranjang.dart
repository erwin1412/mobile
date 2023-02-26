import 'package:kitacollection/model/keranjang.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CListKeranjang extends GetxController {
  final RxList<Keranjang> _list = <Keranjang>[].obs;
  final RxList<int> _selected = <int>[].obs;
  final RxBool _isSelectedAll = false.obs;
  final RxDouble _total = 0.0.obs;

  List<Keranjang> get list => _list.value;
  List<int> get selected => _selected.value;
  bool get isSelectedAll => _isSelectedAll.value;
  double get total => _total.value;

  setList(List<Keranjang> newList) => _list.value = newList;
  addSelected(int newIdKeranjang) {
    _selected.value.add(newIdKeranjang);
    update();
  }

  deleteSelected(int newIdKeranjang) {
    _selected.value.remove(newIdKeranjang);
    update();
  }

  setIsSelectedAll() => _isSelectedAll.value = !_isSelectedAll.value;
  selectedClear() {
    _selected.value.clear();
    update();
  }

  setTotal(double newTotal) => _total.value = newTotal;
}

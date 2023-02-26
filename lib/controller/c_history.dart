import 'package:kitacollection/model/transactions.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CHistory extends GetxController {
  final RxList<Transactions> _list = <Transactions>[].obs;
  final RxList<int> _selected = <int>[].obs;

  List<Transactions> get list => _list.value;
  List<int> get selected => _selected.value;

  setList(List<Transactions> newList) => _list.value = newList;
  addSelected(int newIdTransactions) {
    _selected.value.add(newIdTransactions);
    update();
  }

  deleteSelected(int idTransactions) {
    _selected.value.remove(idTransactions);
    update();
  }

  selectedClear() {
    _selected.value.clear();
    update();
  }
}

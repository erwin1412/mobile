import 'dart:convert';

import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_history.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/transactions.dart';
import 'package:kitacollection/screen/transactions/detail_transactions.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final _cUser = Get.put(CUser());
  final _cHistory = Get.put(CHistory());

  Future<List<Transactions>> getTransactions() async {
    List<Transactions> listTransactions = [];
    try {
      var response = await http.post(Uri.parse(Api.getHistory), body: {
        'id_user': _cUser.user.idUser.toString(),
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          (responseBody['data'] as List).forEach((element) {
            listTransactions.add(Transactions.fromJson(element));
          });
        }
      }
    } catch (e) {
      print(e);
    }
    _cHistory.setList(listTransactions);
    return listTransactions;
  }

  void deleteHistory(int idTransactions, String image) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteTransactions), body: {
        'id_Transactions': idTransactions.toString(),
        'image': image,
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          print('delete id : $idTransactions success');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _cHistory.selectedClear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text('Riwayat Pemesanan'),
        backgroundColor: Asset.colorPrimary,
        actions: [
          GetBuilder(
            init: CHistory(),
            builder: (_) => _cHistory.selected.length > 0
                ? IconButton(
                    onPressed: () async {
                      var response = await Get.dialog(AlertDialog(
                        title: Text('Delete'),
                        content: Text('You sure to delete selected history?'),
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(), child: Text('No')),
                          TextButton(
                              onPressed: () => Get.back(result: 'yes'),
                              child: Text('Yes')),
                        ],
                      ));
                      if (response == 'yes') {
                        _cHistory.list.forEach((transactions) {
                          if (_cHistory.selected
                              .contains(transactions.idTransactions)) {
                            deleteHistory(transactions.idTransactions,
                                transactions.bukti);
                          }
                        });
                        _cHistory.selectedClear();
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.delete_forever))
                : SizedBox(),
          )
        ],
      ),
      body: FutureBuilder(
        future: getTransactions(),
        builder: (context, AsyncSnapshot<List<Transactions>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return Center(child: Text('Empty'));
          }
          if (snapshot.data!.length > 0) {
            List<Transactions> listTransactions = snapshot.data!;
            return ListView.separated(
              padding: EdgeInsets.all(16),
              separatorBuilder: (context, index) {
                return Divider(height: 1, thickness: 1);
              },
              itemCount: listTransactions.length,
              itemBuilder: (context, index) {
                Transactions transactions = listTransactions[index];
                return ListTile(
                  onTap: () =>
                      Get.to(DetailTransactions(transactions: transactions)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: GetBuilder(
                    init: CHistory(),
                    builder: (controller) {
                      return IconButton(
                        onPressed: () {
                          if (_cHistory.selected
                              .contains(transactions.idTransactions)) {
                            _cHistory
                                .deleteSelected(transactions.idTransactions);
                          } else {
                            _cHistory.addSelected(transactions.idTransactions);
                          }
                          print(_cHistory.selected);
                        },
                        icon: Icon(
                          _cHistory.selected
                                  .contains(transactions.idTransactions)
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: _cHistory.selected
                                  .contains(transactions.idTransactions)
                              ? Asset.colorPrimary
                              : Colors.grey,
                        ),
                      );
                    },
                  ),
                  title: Text(
                    CurrencyFormat.convertToIdr(transactions.total + 17000, 2),
                    style: TextStyle(
                      fontSize: 16,
                      color: Asset.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat('dd/MM/yyyy')
                              .format(transactions.tanggal)),
                          SizedBox(height: 4),
                          Text(
                              DateFormat('HH:mm').format(transactions.tanggal)),
                        ],
                      ),
                      Icon(Icons.navigate_next, color: Asset.colorPrimary),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Empty'));
          }
        },
      ),
    );
  }
}

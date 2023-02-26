import 'dart:convert';

import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/transactions.dart';
import 'package:kitacollection/screen/transactions/detail_transactions.dart';

import 'package:kitacollection/screen/transactions/history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FragmentOrder extends StatefulWidget {
  @override
  _FragmentOrderState createState() => _FragmentOrderState();
}

class _FragmentOrderState extends State<FragmentOrder> {
  final _cUser = Get.put(CUser());

  Future<List<Transactions>> getTransactions() async {
    List<Transactions> listTransactions = [];
    try {
      var response = await http.post(Uri.parse(Api.getTransactions), body: {
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
    return listTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 8, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaksi',
                style: TextStyle(
                  color: Asset.colorTextTitle,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Get.to(History()),
                icon: Icon(Icons.history, color: Asset.colorTextTitle),
              ),
            ],
          ),
        ),
        Visibility(
          visible: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Transaction you do',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        Expanded(
          child: buildListTransactions(),
        ),
      ],
    );
  }

  Widget buildListTransactions() {
    return FutureBuilder(
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
                    Get.to(DetailTransactions(transactions: transactions))!
                        .then((value) => setState(() {})),
                contentPadding: EdgeInsets.symmetric(horizontal: 0),
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
                        Text(DateFormat('HH:mm').format(transactions.tanggal)),
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
    );
  }
}

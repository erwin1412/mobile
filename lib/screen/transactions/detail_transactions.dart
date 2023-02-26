import 'dart:convert';

import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/model/transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class DetailTransactions extends StatefulWidget {
  final Transactions transactions;
  DetailTransactions({required this.transactions});

  @override
  _DetailTransactionsState createState() => _DetailTransactionsState();
}

class _DetailTransactionsState extends State<DetailTransactions> {
  RxString _arrived = ''.obs;
  String get arrived => _arrived.value;
  updateArrived(String newArrived) => _arrived.value = newArrived;

  void dialogConfirmArrived() async {
    if (widget.transactions.arrived != 'Arrived') {
      var response = await Get.dialog(AlertDialog(
        title: Text('Konfirmasi Pemesanan'),
        content: Text('Apakah Pesanan Anda Telah Tiba?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('No')),
          TextButton(
              onPressed: () => Get.back(result: 'yes'), child: Text('Yes')),
        ],
      ));
      if (response == 'yes') {
        setArrived();
      }
    }
  }

  void setArrived() async {
    try {
      var response = await http.post(Uri.parse(Api.setArrived), body: {
        'id_transactions': widget.transactions.idTransactions.toString(),
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          updateArrived('Arrived');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    updateArrived(widget.transactions.arrived);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Asset.colorPrimary,
        titleSpacing: 0,
        title: Text(DateFormat('dd/MM/yyyy - HH:mm')
            .format(widget.transactions.tanggal)),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 16, 8),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () => dialogConfirmArrived(),
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        'Arrived',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 8),
                      Obx(() => arrived == 'Arrived'
                          ? Icon(Icons.check_circle, color: Asset.colorPrimary)
                          : Icon(Icons.help, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildListShop(),
              SizedBox(height: 16),
              buildTitle('Pengiriman'),
              SizedBox(height: 8),
              buildContent(widget.transactions.ekspedisi),
              SizedBox(height: 16),
              buildTitle('Jenis Pembayaran'),
              SizedBox(height: 8),
              buildContent(widget.transactions.pembayaran),
              SizedBox(height: 16),
              buildTitle('Alamat'),
              SizedBox(height: 8),
              buildContent(widget.transactions.alamat ?? ''),
              SizedBox(height: 16),
              buildTitle('Total'),
              SizedBox(height: 8),
              buildContent(CurrencyFormat.convertToIdr(
                  widget.transactions.total + 17000, 2)),
              SizedBox(height: 16),
              buildTitle('Buki Pembayaran'),
              SizedBox(height: 8),
              FadeInImage(
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.fitWidth,
                placeholder: AssetImage(Asset.imageBox),
                image: NetworkImage(Api.hostImage + widget.transactions.bukti),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image),
                  );
                },
              ),
              SizedBox(height: 16),
              buildTitle('Status'),
              SizedBox(height: 8),
              SizedBox(height: 16),
              buildContent(widget.transactions.arrived == 'Arrived'
                  ? widget.transactions.arrived
                  : 'Menunggu Konfirmasi'),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }

  Widget buildContent(String content) {
    return Text(
      content,
      style: TextStyle(
        fontSize: 16,
      ),
    );
  }

  Widget buildListShop() {
    List<String> stringListShop = widget.transactions.listShop.split('||');
    return Column(
      children: List.generate(stringListShop.length, (index) {
        Map<String, dynamic> item = jsonDecode(stringListShop[index]);
        return Container(
          margin: EdgeInsets.fromLTRB(
            0,
            index == 0 ? 16 : 8,
            0,
            index == stringListShop.length - 1 ? 16 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              )
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FadeInImage(
                  height: 100,
                  width: 90,
                  fit: BoxFit.cover,
                  placeholder: AssetImage(Asset.imageBox),
                  image: NetworkImage(
                      "https://sistemerwin.my.id/admin/image/" + item['image']),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 100,
                      width: 90,
                      alignment: Alignment.center,
                      child: Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${item['size']}, ${item['color']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        CurrencyFormat.convertToIdr(
                            item['item_total'] as double, 2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Asset.colorPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: false,
                child: Text(
                  item['quantity'].toString(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          ),
        );
      }),
    );
  }
}

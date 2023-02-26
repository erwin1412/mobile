import 'dart:convert';
import 'dart:typed_data';

import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/transactions.dart';
import 'package:kitacollection/screen/transactions/transaction_success.dart';
import 'package:kitacollection/widget/info_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Confirmation extends StatelessWidget {
  final List<Map<String, dynamic>> listShop;
  final double total;
  final List<int> listIdCart;
  final String ekspedisi;
  final String pembayaran;
  final String alamat;
  Confirmation({
    required this.listShop,
    required this.total,
    required this.listIdCart,
    required this.ekspedisi,
    required this.pembayaran,
    required this.alamat,
  });

  RxList<int> _imageByte = <int>[].obs;
  RxString _imageName = ''.obs;
  void setImage(Uint8List newImage) => _imageByte.value = newImage;
  Uint8List get imageByte => Uint8List.fromList(_imageByte);
  void setImageName(String newName) => _imageName.value = newName;
  String get imageName => _imageName.value;

  CUser _cUser = Get.put(CUser());

  void pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setImage(bytes);
      setImageName(path.basename(pickedFile.path));
    }
  }

  void addTransactions() async {
    String stringListShop =
        listShop.map((e) => jsonEncode(e)).toList().join('||');
    Transactions transactions = Transactions(
      idTransactions: 1,
      arrived: '',
      ekspedisi: ekspedisi,
      idUser: _cUser.user.idUser,
      bukti: imageName,
      listShop: stringListShop,
      pembayaran: pembayaran,
      total: total,
      tanggal: DateTime.now(),
      alamat: alamat,
    );
    try {
      var response = await http.post(
        Uri.parse(Api.addTransactions),
        body: transactions.toJson(base64Encode(imageByte)),
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          Get.to(TransactionSuccess());
          listIdCart.forEach((idKeranjang) => deleteCart(idKeranjang));
        } else {
          InfoMessage.snackbar(Get.context!, 'Failed add transactions');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteCart(int idKeranjang) async {
    try {
      var response = await http.post(Uri.parse(Api.deleteKeranjang), body: {
        'id_keranjang': idKeranjang.toString(),
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody['success']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bank BCA 71423152 \n A.N. Kita Collection',
              style: TextStyle(
                color: Asset.colorTextTitle,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 100),
            Text(
              'Tambahkan Bukti Bayar',
              style: TextStyle(
                color: Asset.colorTextTitle,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 30),
            Material(
              elevation: 8,
              color: Asset.colorPrimary,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () => pickImage(),
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    'PILIH GAMBAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    maxHeight: MediaQuery.of(context).size.width * 0.5,
                  ),
                  child: imageByte.length > 0
                      ? Image.memory(
                          imageByte,
                          fit: BoxFit.contain,
                        )
                      : Placeholder(),
                )),
            SizedBox(height: 16),
            Obx(() => Material(
                  elevation: 8,
                  color:
                      imageByte.length > 0 ? Asset.colorPrimary : Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: imageByte.length > 0
                        ? () {
                            addTransactions();
                          }
                        : null,
                    borderRadius: BorderRadius.circular(30),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        'KONFIRMASI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

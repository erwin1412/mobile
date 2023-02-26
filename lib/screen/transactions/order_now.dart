import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_order_now.dart';
import 'package:kitacollection/screen/transactions/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderNow extends StatelessWidget {
  final List<Map<String, dynamic>> listShop;
  final double total;
  final List<int> listIdCart;
  OrderNow({
    required this.listShop,
    required this.total,
    required this.listIdCart,
  });

  List<String> _listEkspedisi = ['Kita Ekspedisi       Rp 17.000,00'];
  List<String> _listPayment = ['Transfer Bank'];
  COrderNow _cOrderNow = Get.put(COrderNow());
  var _controllerNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Asset.colorPrimary,
        titleSpacing: 0,
        title: Text('Pesan Sekarang'),
      ),
      body: ListView(
        children: [
          buildListShop(),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Ekspedisi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _listEkspedisi.map((itemEkspedisi) {
              return Obx(() => RadioListTile<String>(
                    dense: true,
                    activeColor: Asset.colorPrimary,
                    title: Text(
                      itemEkspedisi,
                      style: TextStyle(fontSize: 16),
                    ),
                    value: itemEkspedisi,
                    groupValue: _cOrderNow.ekspedisi,
                    onChanged: (value) {
                      _cOrderNow.setEkspedisi(value!);
                    },
                  ));
            }).toList(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Payment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            children: _listPayment.map((itemPayment) {
              return Obx(() => RadioListTile<String>(
                    dense: true,
                    activeColor: Asset.colorPrimary,
                    title: Text(
                      itemPayment,
                      style: TextStyle(fontSize: 16),
                    ),
                    value: itemPayment,
                    groupValue: _cOrderNow.pembayaran,
                    onChanged: (value) {
                      _cOrderNow.setPembayaran(value!);
                    },
                  ));
            }).toList(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Alamat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _controllerNote,
              decoration: InputDecoration(
                hintText: 'Alamat Anda..',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Asset.colorPrimary,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Asset.colorPrimary,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  Get.to(Confirmation(
                    listIdCart: listIdCart,
                    listShop: listShop,
                    total: total,
                    ekspedisi: _cOrderNow.ekspedisi,
                    alamat: _controllerNote.text,
                    pembayaran: _cOrderNow.pembayaran,
                  ));
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        CurrencyFormat.convertToIdr(total + 17000, 2),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'Bayar Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildListShop() {
    return Column(
      children: List.generate(listShop.length, (index) {
        Map<String, dynamic> item = listShop[index];
        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 8,
            16,
            index == listShop.length - 1 ? 16 : 8,
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

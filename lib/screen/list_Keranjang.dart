import 'dart:convert';

import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_list_keranjang.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/keranjang.dart';
import 'package:kitacollection/model/shoes.dart';
import 'package:kitacollection/screen/detail_shoes.dart';
import 'package:kitacollection/screen/transactions/order_now.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListKeranjang extends StatefulWidget {
  @override
  _ListKeranjangState createState() => _ListKeranjangState();
}

class _ListKeranjangState extends State<ListKeranjang> {
  final _cUser = Get.put(CUser());
  final _cListKeranjang = Get.put(CListKeranjang());

  List<Map<String, dynamic>> getListShop() {
    List<Map<String, dynamic>> listShop = [];
    if (_cListKeranjang.selected.length > 0) {
      _cListKeranjang.list.forEach((keranjang) {
        if (_cListKeranjang.selected.contains(keranjang.idKeranjang)) {
          Map<String, dynamic> item = {
            'id_shoes': keranjang.idShoes,
            'image': keranjang.image,
            'name': keranjang.namaBarang,
            'color': keranjang.color,
            'size': keranjang.size,
            'quantity': keranjang.quantity,
            'item_total': keranjang.price * keranjang.quantity,
          };
          listShop.add(item);
        }
      });
    }
    return listShop;
  }

  void countTotal() {
    _cListKeranjang.setTotal(0.0);
    if (_cListKeranjang.selected.length > 0) {
      _cListKeranjang.list.forEach((keranjang) {
        if (_cListKeranjang.selected.contains(keranjang.idKeranjang)) {
          double itemTotal = keranjang.price * keranjang.quantity;
          _cListKeranjang.setTotal(_cListKeranjang.total + itemTotal);
        }
      });
    }
  }

  void getList() async {
    List<Keranjang> listKeranjang = [];
    try {
      var response = await http.post(Uri.parse(Api.getKeranjang), body: {
        'id_user': _cUser.user.idUser.toString(),
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          (responseBody['data'] as List).forEach((element) {
            listKeranjang.add(Keranjang.fromJson(element));
          });
        }
        _cListKeranjang.setList(listKeranjang);
      }
    } catch (e) {
      print(e);
    }
    countTotal();
  }

  void updateKeranjang(int idKeranjang, int newQuantity) async {
    try {
      var response = await http.post(Uri.parse(Api.updateKeranjang), body: {
        'id_keranjang': idKeranjang.toString(),
        'quantity': newQuantity.toString(),
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          getList();
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
        if (responseBody['success']) {
          getList();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Asset.colorPrimary,
        titleSpacing: 0,
        title: Text('Keranjang'),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                _cListKeranjang.setIsSelectedAll();
                _cListKeranjang.selectedClear();
                if (_cListKeranjang.isSelectedAll) {
                  _cListKeranjang.list.forEach((e) {
                    _cListKeranjang.addSelected(e.idKeranjang);
                  });
                }
                countTotal();
              },
              icon: Icon(
                _cListKeranjang.isSelectedAll
                    ? Icons.check_box
                    : Icons.check_box_outline_blank_rounded,
              ),
            ),
          ),
          GetBuilder(
            init: CListKeranjang(),
            builder: (_) => _cListKeranjang.selected.length > 0
                ? IconButton(
                    onPressed: () async {
                      var response = await Get.dialog(AlertDialog(
                        title: Text('Delete'),
                        content: Text('You sure to delete selected cart?'),
                        actions: [
                          TextButton(
                              onPressed: () => Get.back(), child: Text('No')),
                          TextButton(
                              onPressed: () => Get.back(result: 'yes'),
                              child: Text('Yes')),
                        ],
                      ));
                      if (response == 'yes') {
                        _cListKeranjang.selected.forEach((idKeranjang) {
                          deleteCart(idKeranjang);
                        });
                      }
                      countTotal();
                    },
                    icon: Icon(Icons.delete_forever),
                  )
                : SizedBox(),
          ),
        ],
      ),
      body: Obx(() => _cListKeranjang.list.length > 0
          ? ListView.builder(
              itemCount: _cListKeranjang.list.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                Keranjang keranjang = _cListKeranjang.list[index];
                Shoes shoes = Shoes(
                  idShoes: keranjang.idShoes,
                  colors: keranjang.colors,
                  image: keranjang.image,
                  namaBarang: keranjang.namaBarang,
                  price: keranjang.price,
                  sizes: keranjang.sizes,
                  description: keranjang.description,
                  label: keranjang.label,
                );
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      GetBuilder(
                        init: CListKeranjang(),
                        builder: (_) {
                          return IconButton(
                            onPressed: () {
                              if (_cListKeranjang.selected
                                  .contains(keranjang.idKeranjang)) {
                                _cListKeranjang
                                    .deleteSelected(keranjang.idKeranjang);
                              } else {
                                _cListKeranjang
                                    .addSelected(keranjang.idKeranjang);
                              }
                              countTotal();
                            },
                            icon: Icon(
                              _cListKeranjang.selected
                                      .contains(keranjang.idKeranjang)
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.to(DetailShoes(
                            shoes: shoes,
                          ))!
                              .then((value) => getList()),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                              0,
                              index == 0 ? 16 : 8,
                              16,
                              index == _cListKeranjang.list.length - 1 ? 16 : 8,
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
                                        "https://sistemerwin.my.id/admin/image/" +
                                            keranjang.image),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          keranjang.namaBarang,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '${keranjang.color}, ${keranjang.size}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Visibility(
                                              visible: false,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (keranjang.quantity - 1 >=
                                                      1) {
                                                    updateKeranjang(
                                                      keranjang.idKeranjang,
                                                      keranjang.quantity - 1,
                                                    );
                                                  }
                                                },
                                                child: Icon(
                                                  Icons
                                                      .remove_circle_outline_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Visibility(
                                              visible: false,
                                              child: Text(
                                                keranjang.quantity.toString(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Asset.colorPrimary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Visibility(
                                              visible: false,
                                              child: GestureDetector(
                                                onTap: () {
                                                  updateKeranjang(
                                                    keranjang.idKeranjang,
                                                    keranjang.quantity + 1,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons
                                                      .add_circle_outline_rounded,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              CurrencyFormat.convertToIdr(
                                                  keranjang.price, 2),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Asset.colorPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 16),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text('Empty'),
            )),
      bottomNavigationBar: GetBuilder(
          init: CListKeranjang(),
          builder: (_) => Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -3),
                      color: Colors.black26,
                      blurRadius: 6,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Obx(() => Text(
                          CurrencyFormat.convertToIdr(_cListKeranjang.total, 2),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            color: Asset.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Spacer(),
                    Material(
                      color: _cListKeranjang.selected.length > 0
                          ? Asset.colorPrimary
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        onTap: _cListKeranjang.selected.length > 0
                            ? () => Get.to(
                                  OrderNow(
                                    listShop: getListShop(),
                                    total: _cListKeranjang.total,
                                    listIdCart: _cListKeranjang.selected,
                                  ),
                                )
                            : null,
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                          child: Text(
                            'Pesan Sekarang',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
    );
  }
}

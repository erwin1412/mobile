import 'dart:convert';

import 'package:kitacollection/controller/CurrencyFormat.dart';
import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_detail_shoes.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/shoes.dart';
import 'package:kitacollection/screen/list_Keranjang.dart';
import 'package:kitacollection/widget/info_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailShoes extends StatefulWidget {
  final Shoes? shoes;
  DetailShoes({this.shoes});

  @override
  _DetailShoesState createState() => _DetailShoesState();
}

class _DetailShoesState extends State<DetailShoes> {
  final _cDetailShoes = Get.put(CDetailShoes());
  final _cUser = Get.put(CUser());

  void checkWishlist() async {
    try {
      var response = await http.post(
        Uri.parse(Api.checkFavorite),
        body: {
          'id_user': _cUser.user.idUser.toString(),
          'id_shoes': widget.shoes!.idShoes.toString(),
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        _cDetailShoes.setIsWhislist(responseBody['exist']);
      }
    } catch (e) {
      print(e);
    }
  }

  void addWishlist() async {
    try {
      var response = await http.post(
        Uri.parse(Api.addFavorite),
        body: {
          'id_user': _cUser.user.idUser.toString(),
          'id_shoes': widget.shoes!.idShoes.toString(),
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          checkWishlist();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteWishlist() async {
    try {
      var response = await http.post(
        Uri.parse(Api.deleteFavorite),
        body: {
          'id_user': _cUser.user.idUser.toString(),
          'id_shoes': widget.shoes!.idShoes.toString(),
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          checkWishlist();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void addCart() async {
    try {
      var response = await http.post(
        Uri.parse(Api.addKeranjang),
        body: {
          'id_user': _cUser.user.idUser.toString(),
          'id_shoes': widget.shoes!.idShoes.toString(),
          'quantity': _cDetailShoes.quantity.toString(),
          'size': widget.shoes!.sizes[_cDetailShoes.size],
          'color': widget.shoes!.colors[_cDetailShoes.color],
        },
      );
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          InfoMessage.snackbar(context, 'Berhasil di tambahkan ke keranjang');
        } else {
          InfoMessage.snackbar(context, 'Gagal di tambahkan ke keranjang');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    checkWishlist();
    _cDetailShoes.setQuantity(1);
    _cDetailShoes.setSize(0);
    _cDetailShoes.setColor(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: AssetImage(Asset.imageBox),
            image: NetworkImage(
                "https://sistemerwin.my.id/admin/image/" + widget.shoes!.image),
            imageErrorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.broken_image),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: buildInfo(),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withOpacity(0.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Asset.colorPrimary,
                    ),
                  ),
                  Spacer(),
                  Obx(() => IconButton(
                        onPressed: () {
                          if (_cDetailShoes.isFavorite) {
                            deleteWishlist();
                            _cDetailShoes.setIsWhislist(true);
                          } else {
                            addWishlist();
                            _cDetailShoes.setIsWhislist(false);
                          }
                        },
                        icon: Icon(
                          _cDetailShoes.isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Asset.colorPrimary,
                        ),
                      )),
                  IconButton(
                    onPressed: () => Get.to(ListKeranjang()),
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Asset.colorPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfo() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.black12,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Center(
              child: Container(
                height: 8,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              widget.shoes!.namaBarang,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shoes!.label!.join(', '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        CurrencyFormat.convertToIdr(widget.shoes!.price, 2),
                        style: TextStyle(
                          fontSize: 24,
                          color: Asset.colorPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: false,
                        child: Text(
                          _cDetailShoes.quantity.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: Asset.colorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Ukuran',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.shoes!.sizes.length, (index) {
                return Obx(() => GestureDetector(
                      onTap: () => _cDetailShoes.setSize(index),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 2,
                            color: _cDetailShoes.size == index
                                ? Asset.colorPrimary
                                : Colors.grey,
                          ),
                          color: _cDetailShoes.size == index
                              ? Asset.colorAccent
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.shoes!.sizes[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ));
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Warna',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.shoes!.colors.length, (index) {
                return Obx(() => GestureDetector(
                      onTap: () => _cDetailShoes.setColor(index),
                      child: FittedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              width: 2,
                              color: _cDetailShoes.color == index
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            color: _cDetailShoes.color == index
                                ? Colors.white
                                : Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.shoes!.colors[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ));
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(widget.shoes!.description!),
            SizedBox(height: 30),
            Material(
              elevation: 4,
              color: Asset.colorPrimary,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () => addCart(),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(
                    'Tambahkan ke Keranjang',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

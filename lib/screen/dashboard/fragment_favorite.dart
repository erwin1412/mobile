import 'dart:convert';

import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/model/shoes.dart';
import 'package:kitacollection/model/favorite.dart';
import 'package:kitacollection/screen/detail_shoes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FragmentWhislist extends StatefulWidget {
  @override
  _FragmentWhislistState createState() => _FragmentWhislistState();
}

class _FragmentWhislistState extends State<FragmentWhislist> {
  final _cUser = Get.put(CUser());

  Future<List<Favorite>> getAll() async {
    List<Favorite> listFavorite = [];
    try {
      var response = await http.post(Uri.parse(Api.getFavorite), body: {
        'id_user': _cUser.user.idUser.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(jsonDecode(response.body));
        if (responseBody['success']) {
          (responseBody['data'] as List).forEach((element) {
            listFavorite.add(Favorite.fromJson(element));
          });
        }
      }
    } catch (e) {}
    return listFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 8, 8),
            child: Text(
              'Favorite',
              style: TextStyle(
                color: Asset.colorTextTitle,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Hope all of this can purchased',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
          buildAll(),
        ],
      ),
    );
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getAll(),
      builder: (context, AsyncSnapshot<List<Favorite>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == null) {
          return Center(child: Text('Empty'));
        }
        if (snapshot.data!.length > 0) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              Favorite favorite = snapshot.data![index];
              Shoes shoes = Shoes(
                idShoes: favorite.idShoes,
                colors: favorite.colors,
                image: favorite.image,
                namaBarang: favorite.namaBarang,
                price: favorite.price,
                sizes: favorite.sizes,
                description: favorite.description,
                label: favorite.label,
              );
              return GestureDetector(
                onTap: () => Get.to(DetailShoes(shoes: shoes))!
                    .then((value) => setState(() {})),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    16,
                    index == 0 ? 16 : 8,
                    16,
                    index == snapshot.data!.length - 1 ? 16 : 8,
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
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          placeholder: AssetImage(Asset.imageBox),
                          image: NetworkImage(
                              "https://sistemerwin.my.id/admin/image/" +
                                  shoes.image),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Center(
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
                                shoes.namaBarang,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '${shoes.label!.join(', ')}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$ ${shoes.price}',
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
                      Icon(Icons.navigate_next, size: 30),
                      SizedBox(width: 16),
                    ],
                  ),
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

import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/event/event_pref.dart';
import 'package:kitacollection/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FragmentProfile extends StatelessWidget {
  final _cUser = Get.put(CUser());

  void logout() async {
    var response = await Get.dialog(
      AlertDialog(
        title: Text('Logout'),
        content: Text('You sure to logout?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('No')),
          TextButton(
              onPressed: () => Get.back(result: 'yes'), child: Text('Yes')),
        ],
      ),
    );
    if (response == 'yes') {
      EventPref.deleteUser().then((value) {
        Get.off(Login());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Text(
              "Kita Collection",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Asset.colorTextTitle,
              ),
            ),
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 30)),
        SizedBox(height: 10),
        Center(
          child: Container(),
        ),
        SizedBox(height: 30),
        Text(
          "Nama User",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildItemProfile(Icons.person_pin, _cUser.user.name),
        SizedBox(height: 16),
        Text(
          "Email User",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildItemProfile(Icons.alternate_email_sharp, _cUser.user.email),
        SizedBox(height: 16),
        Text(
          "No Telephone User",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        buildItemProfile(Icons.contact_phone, _cUser.user.phone),
        SizedBox(height: 30),
        Container(
          child: GestureDetector(
            onTap: () => logout(),
            child: Container(
              margin: EdgeInsets.fromLTRB(
                32,
                30,
                32,
                30,
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
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 30,
                                color: Asset.colorTextTitle,
                              ),
                            )),
                        Icon(Icons.navigate_next, size: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildItemProfile(IconData icon, String data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Asset.colorAccent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Asset.colorPrimary,
          ),
          SizedBox(
            width: 16,
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

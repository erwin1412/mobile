import 'dart:convert';

import 'package:kitacollection/model/api.dart';
import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/event/event_pref.dart';
import 'package:kitacollection/model/user.dart';
import 'package:kitacollection/screen/auth/register.dart';
import 'package:kitacollection/screen/dashboard/dashboard.dart';
import 'package:kitacollection/widget/info_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  var _controllerEmail = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var _obsecure = true.obs;

  void login() async {
    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {
          'email': _controllerEmail.text,
          'password': _controllerPassword.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          InfoMessage.snackbar(Get.context!, 'Login Berhasil');
          User user = User.fromJson(responseBody['data']);
          await EventPref.saveUser(user);
          Future.delayed(Duration(milliseconds: 1500), () {
            Get.off(Dashboard());
          });
        } else {
          InfoMessage.snackbar(Get.context!, 'Login Gagal');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 132, 132, 132),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildHeader(),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 300,
                    ),
                    child: buildForm(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      width: MediaQuery.of(Get.context!).size.width,
      height: 300,
      padding: EdgeInsets.fromLTRB(30, 0, 30, 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            'Kita Collection',
            style: TextStyle(
              fontSize: 60,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 24,
              color: Asset.colorAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black26,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 30, 30, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controllerEmail,
                    validator: (value) => value == '' ? "Don't Empty" : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.alternate_email_sharp,
                        color: Asset.colorPrimary,
                      ),
                      hintText: 'email@gmail.com',
                      border: styleBorder(),
                      enabledBorder: styleBorder(),
                      focusedBorder: styleBorder(),
                      disabledBorder: styleBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      fillColor: Asset.colorAccent,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 16),
                  Obx(
                    () => TextFormField(
                      controller: _controllerPassword,
                      validator: (value) => value == '' ? "Don't Empty" : null,
                      obscureText: _obsecure.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Asset.colorPrimary,
                        ),
                        hintText: 'Password',
                        suffixIcon: Obx(
                          () => GestureDetector(
                            onTap: () {
                              _obsecure.value = !_obsecure.value;
                            },
                            child: Icon(
                              _obsecure.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Asset.colorPrimary,
                            ),
                          ),
                        ),
                        border: styleBorder(),
                        enabledBorder: styleBorder(),
                        focusedBorder: styleBorder(),
                        disabledBorder: styleBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        fillColor: Asset.colorAccent,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Material(
                    color: Asset.colorPrimary,
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          print('login');
                          login();
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 12,
                        ),
                        child: Text(
                          'LOGIN',
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not have account?'),
                TextButton(
                  onPressed: () {
                    Get.to(Register());
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Asset.colorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        width: 0,
        color: Asset.colorAccent,
      ),
    );
  }
}

import 'package:kitacollection/model/asset.dart';
import 'package:kitacollection/controller/c_user.dart';
import 'package:kitacollection/screen/dashboard/fragment_home.dart';
import 'package:kitacollection/screen/dashboard/fragment_transactions.dart';
import 'package:kitacollection/screen/dashboard/fragment_profile.dart';
import 'package:kitacollection/screen/dashboard/fragment_favorite.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  RxInt _index = 0.obs;
  List<Widget> _fragments = [
    FragmentHome(),
    FragmentWhislist(),
    FragmentOrder(),
    FragmentProfile(),
  ];
  List _navs = [
    {
      'icon_on': Icons.home,
      'icon_off': Icons.home_outlined,
      'label': 'Products',
    },
    {
      'icon_on': Icons.bookmark,
      'icon_off': Icons.bookmark_border,
      'label': 'Favorite',
    },
    {
      'icon_on': FontAwesomeIcons.boxOpen,
      'icon_off': FontAwesomeIcons.box,
      'label': 'Transactions',
    },
    {
      'icon_on': Icons.account_circle,
      'icon_off': Icons.account_circle_outlined,
      'label': 'Profile',
    },
  ];

  CUser _cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CUser(),
      initState: (state) {
        _cUser.getUser();
      },
      builder: (controller) {
        return Scaffold(
          body: SafeArea(child: Obx(() => _fragments[_index.value])),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: _index.value,
              onTap: (value) => _index.value = value,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Asset.colorTextTitle,
              unselectedItemColor: Asset.colorTextTitle,
              items: List.generate(4, (index) {
                var nav = _navs[index];
                return BottomNavigationBarItem(
                  icon: Icon(nav['icon_off']),
                  label: nav['label'],
                  activeIcon: Icon(nav['icon_on']),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

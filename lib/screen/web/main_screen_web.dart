import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streaming_flix_admin/controller/main_controller.dart';

class MainScreen extends StatelessWidget {
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<CollapsibleItem> _items = mainController.generateItems;
    NetworkImage _avatarImg =
    NetworkImage('https://www.w3schools.com/howto/img_avatar.png');
    return Scaffold(
      body: SafeArea(
        child: CollapsibleSidebar(
          items: _items,
          avatarImg: _avatarImg,
          title: 'Admin',
          onTitleTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Yay! Flutter Collapsible Sidebar!'),
              ),
            );
          },
          body: Obx(() {
            return IndexedStack(
              index: mainController.index.value,
              children: mainController.pages,
            );
          }),
          backgroundColor: Colors.black,
          selectedTextColor: Colors.white,
          textStyle: TextStyle(
            fontSize: 15,
          ),
          titleStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          toggleTitleStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

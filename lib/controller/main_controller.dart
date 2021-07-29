import 'package:collapsible_sidebar/collapsible_sidebar/collapsible_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:streaming_flix_admin/screen/web/add_video_screen_web.dart';
import 'package:streaming_flix_admin/screen/web/control_advertisement_video_screen.dart';
import 'package:streaming_flix_admin/screen/web/list_video_screen_web.dart';
import 'package:streaming_flix_admin/screen/web/search_screen_video_web.dart';

class MainController extends GetxController {
  var pages = [
    AddVideoScreenWeb(),
    ListVideoScreenWeb(),
    SearchVideoScreenWeb(),
    ControlAdvertisementVideoScreenWeb(),
  ];
  var index = 0.obs;

  List<CollapsibleItem> get generateItems {
    return [
      CollapsibleItem(
        text: 'Add Video',
        icon: Icons.video_call_rounded,
        onPressed: () {
          index.value = 0;
        },
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'List Video',
        icon: Icons.featured_play_list_rounded,
        onPressed: () {
          index.value = 1;
        },
      ),
      CollapsibleItem(
        text: 'Search',
        icon: Icons.search_rounded,
        onPressed: () {
          index.value = 2;
        },
      ),
      CollapsibleItem(
        text: 'Control Advertisement',
        icon: Icons.tv_rounded,
        onPressed: () {
          index.value = 3;
        },
      ),
    ];
  }
}

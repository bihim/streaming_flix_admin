import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:streaming_flix_admin/binding/main_binding.dart';
import 'package:streaming_flix_admin/screen/web/add_video_screen_web.dart';
import 'package:streaming_flix_admin/screen/web/list_video_screen_web.dart';
import 'package:streaming_flix_admin/screen/web/main_screen_web.dart';
import 'package:streaming_flix_admin/screen/web/search_screen_video_web.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return GetMaterialApp(
        title: 'Streaming Flix Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: ()=>MainScreen(), binding: MainBinding()),
          /*GetPage(name: '/add', page: ()=>AddVideoScreenWeb()),
          GetPage(name: '/list', page: ()=>ListVideoScreenWeb()),
          GetPage(name: '/search', page: ()=>SearchVideoScreenWeb()),*/
        ],
      );
    });
  }
}

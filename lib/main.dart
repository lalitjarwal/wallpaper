import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/src/views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ApiManager.getTrending();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      defaultTransition: Transition.fadeIn,
      theme: ThemeData.dark().copyWith(
          textSelectionTheme: TextSelectionTheme.of(context)
              .copyWith(cursorColor: Colors.tealAccent)),
      home: Home(),
    );
  }
}

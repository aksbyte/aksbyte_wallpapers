import 'package:aksbyte_wallpapers/chroma.dart';
import 'package:aksbyte_wallpapers/views/screens/category.dart';
import 'package:aksbyte_wallpapers/views/screens/home_page.dart';
import 'package:aksbyte_wallpapers/views/screens/search.dart';
import 'package:aksbyte_wallpapers/views/widgets/photo_action.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aksbyte Wallpapers',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        //scaffoldBackgroundColor: Chroma.whiteColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Chroma.whiteColor,
          centerTitle: true,
        ),
      ),
      home: HomePage(),
    );
  }
}

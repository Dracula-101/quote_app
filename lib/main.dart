import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:quote_app/decorations/colors.dart';
import 'package:quote_app/pages/swap_page.dart';
import 'pages/Home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quote App',
      home: SwapPage(),
      theme: ThemeData(
        primaryColor: primaryColor,
        secondaryHeaderColor: purpleColor,
        scaffoldBackgroundColor: scaffoldColor,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.rubik().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quote_app/decorations/colors.dart';
import 'package:quote_app/pages/Favourites/favourites.dart';
import 'package:quote_app/pages/Home/home_page.dart';

class SwapPage extends StatefulWidget {
  SwapPage({Key? key}) : super(key: key);

  @override
  State<SwapPage> createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          //extremely usefull for caching pages
          child: IndexedStack(
            index: currentTab,
            children: [
              const HomePage(),
              Favourites(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          // ← carves notch for FAB in BottomAppBar
          elevation: 6,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            unselectedFontSize: 14,
            elevation: 4,
            selectedIconTheme: IconThemeData(
              color: primaryColor,
              size: 27,
            ),
            unselectedIconTheme: const IconThemeData(
              color: Colors.black54,
              size: 27,
            ),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: const TextStyle(
              color: Colors.black,
            ),
            currentIndex: currentTab,
            // fixedColor: primaryColor,
            selectedItemColor: primaryColor,
            onTap: (int index) {
              setState(() {
                currentTab = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.house_outlined,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_border,
                    // color: Colors.black54,
                    size: 27,
                  ),
                  label: 'Favourites'),
            ],
          ),
        ));
  }
}

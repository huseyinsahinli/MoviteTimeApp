import 'package:firebase_islemleri/pages/favorite_page.dart';
import 'package:firebase_islemleri/pages/home_page.dart';
import 'package:firebase_islemleri/pages/profile_page.dart';
import 'package:firebase_islemleri/constants/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (value) => setState(() {
          _selectedIndex = value;
        }),
        children: [
          HomePage(),
          FavoriteMoviesPage(),
          ProfilePage(),
        ],
        controller: pageController,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xff1b1b1b),
              blurRadius: 12,
            ),
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          backgroundColor: Constants.mainColor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Main",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: "Favorite",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: onTap,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:social_boster/providers/user_provider.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/hashtag_screen/hashtag_screen.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/home_screen/home_screen.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/setting_screen.dart';
import 'package:social_boster/screens/bottom_nav_bar_screen/trending_screens/trending_screen.dart';
import 'package:provider/provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  final List pages = [
    const HomeScreen(),
    const HashTagScreen(),
    const TrendingScreen(),
    const TrendingScreen(),
    const SettingScreen()
  ];
  @override
  void initState() {
    Provider.of<UserProvider>(context,listen:false).getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (v) {
          setState(() {
            _currentIndex = v;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.tag_sharp), label: "Hashtag"),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: "Trending"),
          BottomNavigationBarItem(
              icon: Icon(Icons.share), label: "Social"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

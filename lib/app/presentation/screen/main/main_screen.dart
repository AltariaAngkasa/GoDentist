import 'package:GoDentist/app/presentation/controllers/c_history.dart';
import 'package:GoDentist/app/presentation/controllers/c_home.dart';
import 'package:GoDentist/app/presentation/screen/education/education_screen.dart';
import 'package:GoDentist/app/presentation/screen/history/history_screen.dart';
import 'package:GoDentist/app/presentation/screen/home/home_screen.dart';
import 'package:GoDentist/app/presentation/screen/setting/setting_screen.dart';
import 'package:GoDentist/app/utils/constants/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = const [
    HomeScreen(),
    HistoryScreen(),
    EducationScreen(),
    SettingScreen(),
  ];

  final cHome = Get.put(CHome());
  final cHistory = Get.put(CHistory());

  @override
  void initState() {
    super.initState();
    cHome;
    cHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: ColorConstant.primaryColor),
        selectedItemColor: ColorConstant.primaryColor,
        unselectedItemColor: Colors.grey,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

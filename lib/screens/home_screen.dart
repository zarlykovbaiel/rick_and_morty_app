import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rick_and_morty/presentation/theme/app_colors.dart';
import 'package:rick_and_morty/resources/resources.dart';
import 'package:rick_and_morty/screens/charecter_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const CharectersPage(),
    const Scaffold(body: Text('2')),
    const Scaffold(body: Text('3')),
    const Scaffold(body: Text('4')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.darkTextColor,
        currentIndex: currentIndex,
        onTap: (val) {
          currentIndex = val;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppSvgs.chars), label: 'Персонажи'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppSvgs.location), label: 'Локации'),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppSvgs.episode,
            ),
            label: 'Эпизоды',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppSvgs.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}

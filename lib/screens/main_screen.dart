import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space/screens/account_screen.dart';

import 'package:space/screens/journal/journals_screen.dart';
import 'package:space/utils/theme/app_state_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController controller = PageController();
  final int _currentIndex = 0;
  final List<Widget> _screens = [
    const JournalsScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: value.pageState,
            selectedItemColor: Colors.blueAccent,
            onTap: (index) {
              value.updatePage(index);
              controller.jumpToPage(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.note),
                label: "Journal",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
          body: PageView(
            controller: controller,
            children: _screens,
            onPageChanged: (index) {
              value.updatePage(index);
            },
          ),
        );
      },
    );
  }
}

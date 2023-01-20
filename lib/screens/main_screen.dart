import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:space/auth/local_auth/local_authentication.dart';
import 'package:space/screens/account_screen.dart';

import 'package:space/screens/journal/journals_screen.dart';
import 'package:space/utils/App%20State/app_state_provider.dart';
import 'package:space/utils/pref.dart';

import 'journal/add_journal_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const JournalsScreen(),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Semantics(
            label: 'Add Journal',
            hint: 'Press to add journal',
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const AddJournalScreen();
                })).then((value) {
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                        statusBarColor: Theme.of(context)
                            .primaryColor //or set color with: Color(0xFF0000FF)
                        ),
                  );
                });
              },
              child: Icon(
                Icons.add,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20.r,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24.r,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Theme.of(context).primaryColor,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: CupertinoIcons.layers,
                      text: 'Journals',
                      iconColor: Theme.of(context).textTheme.titleLarge?.color,
                      iconActiveColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                      textColor: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    GButton(
                      icon: CupertinoIcons.settings,
                      text: 'Settings',
                      iconColor: Theme.of(context).textTheme.titleLarge?.color,
                      iconActiveColor:
                          Theme.of(context).textTheme.titleLarge?.color,
                      textColor: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ],
                  selectedIndex: value.pageState,
                  onTabChange: (index) {
                    value.updatePage(index);
                  },
                ),
              ),
            ),
          ),
          body: _screens[value.pageState],
        );
      },
    );
  }

  void _authenticate() async {
    if (SharedPreferencesHelper.getAuthPermission() == true) {
      await LocalAuthApi.authenticate();
    }
  }
}

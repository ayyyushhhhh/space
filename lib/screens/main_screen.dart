import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const AddJournalScreen();
              }));
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    minWidth: 40.w,
                    onPressed: () {
                      value.updatePage(0);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add,
                          size: 20.r,
                          color: (value.pageState == 0)
                              ? Colors.blue
                              : Colors.white,
                        ),
                        Text(
                          "Journal",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: (value.pageState == 0)
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40.w,
                    onPressed: () {
                      value.updatePage(1);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          size: 24.r,
                          color: (value.pageState == 1)
                              ? Colors.blue
                              : Colors.white,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: (value.pageState == 1)
                                ? Colors.blue
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
